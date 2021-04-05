require 'rails_helper'

describe Jwt::Issuer do
  let(:user) { create(:user) }

  describe '#call' do
    it 'should include the encoded access_token' do
      response = subject.call(user)
      expect(response[:access_token]).not_to be_blank
    end

    context 'when the user have a active refresh_token associated' do
      let!(:refresh_token) { create(:refresh_token, user: user) }

      it 'should not create a new refresh token' do
        expect { subject.call(user) }
          .not_to(change { RefreshToken.count })
      end

      it 'should include the existing token on the response' do
        expect(subject.call(user)).to include(refresh_token: refresh_token.encrypted_token)
      end
    end

    context 'when the user does not have an active refresh_token associated' do
      it 'should create a new refresh token' do
        expect { subject.call(user) }
          .to change { RefreshToken.count }.by(1)
      end

      it 'should include the existing token on the response' do
        response = subject.call(user)
        created_refresh_token = RefreshToken.last

        expect(response).to include(refresh_token: created_refresh_token.encrypted_token)
      end
    end
  end
end
