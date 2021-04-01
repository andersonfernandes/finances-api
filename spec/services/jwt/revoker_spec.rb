require 'rails_helper'

describe Jwt::Revoker do
  describe '#call' do
    let!(:user) do
      user = create(:user)
      create(:refresh_token, user: user)
      user
    end

    context 'with a valid access_token' do
      let(:token) { create(:token, user: user, status: :active) }
      let(:access_token) do
        JWT.encode(
          {
            user_id: user.id,
            exp: 2.days.from_now.to_i,
            jti: token.jwt_id
          },
          Figaro.env.secret_key_base
        )
      end

      it { expect(subject.call(access_token)).to eq(true) }

      it 'the token should change to :revoked' do
        subject.call(access_token)
        expect(token.reload.status).to eq('revoked')
      end

      it 'the user refresh token should be destroyed' do
        subject.call(access_token)
        expect(user.reload.refresh_token).to be_nil
      end
    end

    context 'with an already revoked token' do
      let(:token) { create(:token, user: user, status: :revoked) }
      let(:access_token) do
        JWT.encode(
          {
            user_id: user.id,
            exp: 2.days.from_now.to_i,
            jti: token.jwt_id
          },
          Figaro.env.secret_key_base
        )
      end

      it { expect(subject.call(access_token)).to eq(true) }

      it 'the token should maintain the revoked status' do
        subject.call(access_token)
        expect(token.status).to eq('revoked')
      end
    end

    context 'with an invalid access_token' do
      let(:access_token) { 'invalid_access_token' }

      it { expect { subject.call(access_token) }.to raise_error(Jwt::Errors::InvalidToken) }
    end
  end
end
