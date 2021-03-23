require 'rails_helper'

describe Jwt::Issuer do
  let(:user) { create(:user) }
  subject { described_class.new(user) }

  describe '#call' do
    it 'should include the encoded access_token' do
      response = subject.call
      expect(response[:access_token]).not_to be_blank
    end

    context 'when the user have a active refresh_token associated' do
      let!(:refresh_token) { create(:refresh_token, status: :active, user: user) }

      it 'should not create a new refresh token' do
        expect { subject.call }
          .not_to(change { RefreshToken.count })
      end

      it 'should include the existing token on the response' do
        expect(subject.call).to include(refresh_token: refresh_token.token)
      end
    end

    context 'when the user does not have an active refresh_token associated' do
      it 'should create a new refresh token' do
        expect { subject.call }
          .to change { RefreshToken.count }.by(1)
      end

      it 'should include the existing token on the response' do
        response = subject.call
        created_refresh_token = RefreshToken.last

        expect(response).to include(refresh_token: created_refresh_token.token)
      end
    end
  end
end
