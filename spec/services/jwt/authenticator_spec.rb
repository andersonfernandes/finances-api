require 'rails_helper'

describe Jwt::Authenticator do
  subject { described_class.new(headers) }

  context 'when the access_token is missing' do
    let(:headers) { {} }

    it do
      expect { subject.call }.to raise_error(Jwt::Errors::MissingToken)
    end
  end

  context 'when the access_token is present' do
    let(:user) { create(:user) }
    let(:headers) { { 'Authorization' => "Baerer #{access_token}" } }

    context 'and the access_token is valid' do
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

      it do
        expect(subject.call).to eq(user)
      end
    end

    context 'and the token have a revoked status' do
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

      it do
        expect { subject.call }.to raise_error(Jwt::Errors::RevokedToken)
      end
    end
  end
end
