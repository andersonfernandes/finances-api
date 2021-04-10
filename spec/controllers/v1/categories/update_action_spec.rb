require 'rails_helper'

RSpec.describe V1::CategoriesController, '#update', type: :request do
  let(:setup) {}
  let(:user) { create(:user) }
  let(:category) do
    create(:category, user: user, parent_category: create(:category))
  end

  let(:params) { { description: 'Category A' } }
  let(:headers) { authorization_header(user) }

  before do
    setup
    put v1_category_path(category), params: params, headers: headers
  end

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the category belongs to the current user' do
      it do
        expect(response).to have_http_status(:ok)
        expect(response_body).to include('description' => params[:description])
          .and include('parent_category_id' => category.parent_category_id)
      end
    end

    context 'and the category does not exist' do
      let(:category) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find Category with 'id'=-1"
        expect(response_body).to include('errors' => error_message)
      end
    end

    context 'and the update action fails' do
      let(:setup) { allow_any_instance_of(Category).to receive(:update).and_return(false) }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body).to include('message' => 'Unprocessable Entity')
      end
    end
  end
end
