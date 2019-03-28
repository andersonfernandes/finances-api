require 'rails_helper'

RSpec.describe V1::CategoriesController, '#create',
               type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:setup) {}
  let(:user) { create(:user) }

  let(:params) { { description: 'Category A' } }
  let(:headers) { authorization_header(user.id) }

  before do
    setup
    post v1_categories_path, params: params, headers: headers
  end

  context 'when the user is authenticated' do
    context 'with missing params' do
      let(:params) { {} }

      it { expect(response).to have_http_status(:bad_request) }
    end

    context 'with valid params' do
      it { expect(response).to have_http_status(:created) }
      it { expect(body).to include('description' => params[:description]) }
    end
  end

  context 'when the user is not authenticated' do
    let(:headers) { {} }
    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(body).to include('message' => 'Unauthorized') }
  end
end
