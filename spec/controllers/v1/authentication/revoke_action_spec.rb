require 'rails_helper'

RSpec.describe V1::AuthenticationController, '#revoke', type: :request do
  let(:user) { create(:user) }
  let(:token) { create(:token, user: user, status: :active) }
  let(:access_token) do
    JWT.encode(
      token.access_token_payload,
      ENV['SECRET_KEY_BASE']
    )
  end

  before { post v1_auth_revoke_path, headers: headers }

  include_context 'when the Authorization header is missing'

  context 'with valid params' do
    let(:headers) { { 'Authorization' => "Bearer #{access_token}" } }

    it { expect(response).to have_http_status(:no_content) }

    it 'the old token should be revoked' do
      expect(token.reload.status).to eq 'revoked'
    end
  end
end
