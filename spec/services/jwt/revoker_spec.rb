require 'rails_helper'

describe Jwt::Revoker do
  describe '#call' do
    let!(:user) do
      user = create(:user)
      create(:refresh_token, user: user)
      user
    end
    let(:token) { create(:token, user: user, status: token_status) }
    let(:access_token) do
      JWT.encode(
        {
          user_id: user.id,
          exp: 2.days.from_now.to_i,
          jti: token.jwt_id
        },
        ENV['SECRET_KEY_BASE']
      )
    end

    context 'with a valid access_token' do
      let(:token_status) { :active }

      it { expect(subject.call(access_token)).to eq(true) }

      it 'the token should change to :revoked' do
        subject.call(access_token)
        expect(token.reload.status).to eq('revoked')
      end
    end

    context 'with an already revoked token' do
      let(:token_status) { :revoked }

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
