require 'rails_helper'

RSpec.describe V1::AuthenticationController, '#access_token', type: :request do
  let!(:user) { create(:user) }
  let!(:refresh_token) { create(:refresh_token, user: user).encrypted_token }
  let(:token) { create(:token, user: user, status: :active) }
  let(:access_token) do
    JWT.encode(
      token.access_token_payload,
      Figaro.env.secret_key_base
    )
  end

  let(:params) { {} }
  let(:headers) { {} }

  before { post(v1_auth_refresh_token_path, params: params, headers: headers) }

  include_context 'when the Authorization header is missing' do
    let(:params) { { refresh_token: refresh_token } }
  end

  context 'when the refresh_token param is missing' do
    let(:params) { {} }
    let(:headers) { { 'Authorization' => "Bearer #{access_token}" } }

    it { expect(response).to have_http_status(:bad_request) }
    it do
      expect(response_body).to include('message' => 'Bad Request')
        .and include('errors' => 'Missing parameter refresh_token')
    end
  end

  context 'with valid params' do
    let(:params) { { refresh_token: refresh_token } }
    let(:headers) { { 'Authorization' => "Bearer #{access_token}" } }

    it { expect(response).to have_http_status(:ok) }

    it do
      new_token = Token.last
      expected_access_token = JWT.encode(
        new_token.access_token_payload,
        Figaro.env.secret_key_base
      )

      expect(response_body).to include('access_token' => expected_access_token)
        .and include('refresh_token' => refresh_token)
    end

    it 'the old token should be revoked' do
      expect(token.reload.status).to eq 'revoked'
    end
  end
end
