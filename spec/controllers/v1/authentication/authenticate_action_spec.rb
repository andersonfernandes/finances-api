require 'rails_helper'

RSpec.describe V1::AuthenticationController, '#authenticate',
               type: :controller do
  let(:params) { { email: email, password: password } }
  let(:body) { JSON.parse(response.body) }
  let(:setup) {}

  before do
    setup
    get :authenticate, params: params
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
    let(:expected_token) { JsonWebToken.encode(user_id: user.id) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(body).to include('token' => expected_token) }
  end

  context 'when the user credentials are invalid' do
    let(:email) { 'invalid@mail.com' }
    let(:password) { 'wrong_password' }
    let(:expected_message) { 'Credentials were missing or incorrect' }

    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(body).to include('message' => expected_message) }
  end
end
