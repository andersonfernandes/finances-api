require 'rails_helper'

RSpec.describe V1::CategoriesController, '#update',
               type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:users) { [user] }
  let(:category) { create(:category, users: users) }

  let(:params) { { description: 'Category A' } }
  let(:headers) { authorization_header(user.id) }

  before { put v1_category_path(category), params: params, headers: headers }

  context 'when the user is authenticated' do
    context 'and the category belongs to the current user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(body).to include('description' => params[:description]) }
    end

    context 'and the category does not belongs to the user' do
      let(:users) { [create(:user)] }
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  context 'when the user is not authenticated' do
    let(:headers) { {} }
    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(body).to include('message' => 'Unauthorized') }
  end
end
