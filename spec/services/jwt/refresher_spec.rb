require 'rails_helper'

describe Jwt::Refresher do
  let!(:user) { create(:user) }
  let!(:refresh_token) { create(:refresh_token, user: user).encrypted_token }
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

  context 'with a valid access_token and refresh_token' do
    let(:user) { create(:user) }
    let!(:token) { create(:token, user: user, status: :active) }

    it 'the refresh_token should not change' do
      expect(subject.call(refresh_token, access_token)).to include(refresh_token: refresh_token)
    end

    it 'a new token should be created on the database' do
      expect { subject.call(refresh_token, access_token) }.to change { Token.count }.from(1).to(2)
    end

    it 'the old token should be revoked' do
      subject.call(refresh_token, access_token)
      expect(token.reload.status).to eq('revoked')
    end
  end

  context 'with a valid refresh_token and an invalid access_token' do
    let!(:token) { create(:token, user: user, status: :revoked) }

    it do
      expect { subject.call(refresh_token, access_token) }.to raise_error(Jwt::Errors::RevokedToken)
    end
  end

  context 'with a invalid refresh_token and an valid access_token' do
    let!(:token) { create(:token, user: user, status: :active) }

    before { user.refresh_token.destroy }

    it do
      expect { subject.call(refresh_token, access_token) }
        .to raise_error(Jwt::Errors::MissingRefreshToken)
    end
  end
end
