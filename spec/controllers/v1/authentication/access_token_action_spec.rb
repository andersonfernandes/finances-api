require 'rails_helper'

RSpec.describe V1::AuthenticationController, '#access_token', type: :request do
  let(:params) { { email: email, password: password } }
  let(:body) { JSON.parse(response.body) }
  let(:setup) { }

  before do
    setup
    post(v1_auth_access_token_path, params: params)
  end

  context 'when the params are missing' do
    let(:params) { {} }

    it { expect(response).to have_http_status(:bad_request) }
  end

  context 'when the user credentials are valid' do
    let(:email) { 'john@mail.com' }
    let(:password) { 'correct_password' }
    let(:user) { create(:user, email: email, password: password) }
    let(:setup) { user }

    it { expect(response).to have_http_status(:ok) }

    it do
      token = Token.last
      expected_access_token = JWT.encode(
        token.access_token_payload,
        Figaro.env.secret_key_base
      )
      expected_refresh_token = RefreshToken.last.encrypted_token

      expect(body).to include('access_token' => expected_access_token)
        .and include('refresh_token' => expected_refresh_token)
    end
  end

  context 'when the user credentials are invalid' do
    let(:email) { 'invalid@mail.com' }
    let(:password) { 'wrong_password' }

    it { expect(response).to have_http_status(:unauthorized) }

    it { expect(body).to include('message' => 'Unauthorized') }
  end
end
