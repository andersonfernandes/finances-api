require 'rails_helper'

describe Jwt::Authenticator do
  context 'when the access_token is missing' do
    let(:access_token) { nil }

    it do
      expect { subject.call(access_token) }.to raise_error(Jwt::Errors::MissingToken)
    end
  end

  context 'when the access_token is present' do
    let(:user) { create(:user) }
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

    context 'and the access_token is valid' do
      let(:token_status) { :active }

      it do
        expect(subject.call(access_token)).to match_array([user, token])
      end
    end

    context 'and the token have a revoked status' do
      let(:token_status) { :revoked }

      it do
        expect { subject.call(access_token) }.to raise_error(Jwt::Errors::RevokedToken)
      end
    end
  end
end
