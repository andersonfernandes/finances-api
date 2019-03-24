require 'rails_helper'

RSpec.describe V1::AuthenticationController, type: :controller do
  let(:params) { { email: email, password: password } }
  let(:body) { JSON.parse(response.body) }
  let(:setup) {}

  before do
    setup
    get :authenticate, params: params
  end

  context 'when the user credentials are valid' do
    let(:email) { 'john@mail.com' }
    let(:password) { 'correct_password' }
    let(:setup) { create(:user, email: email, password: password) }

    it { expect(response).to have_http_status(:ok) }
  end

  context 'when the user credentials are invalid' do
    let(:email) { 'invalid@mail.com' }
    let(:password) { 'wrong_password' }

    it { expect(response).to have_http_status(:unauthorized) }
  end
end
