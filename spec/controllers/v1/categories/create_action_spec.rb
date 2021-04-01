require 'rails_helper'

RSpec.describe V1::CategoriesController, '#create', type: :request do
  let(:setup) {}
  let(:user) { create(:user) }

  let(:params) { { description: 'Category A' } }
  let(:headers) { authorization_header(user) }

  before do
    setup
    post v1_categories_path, params: params, headers: headers
  end

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'with missing params' do
      let(:params) { {} }

      it { expect(response).to have_http_status(:bad_request) }
    end

    context 'with valid params' do
      context 'and no parent category' do
        it do
          expect(response).to have_http_status(:created)
          expect(response_body)
            .to include('description' => params[:description])
            .and include('parent_category_id' => nil)
        end
      end

      context 'and a parent category' do
        let(:parent_category) { create(:category) }
        let(:params) do
          {
            description: 'Category B',
            parent_category_id: parent_category.id
          }
        end

        it do
          expect(response).to have_http_status(:created)
          expect(response_body)
            .to include('description' => params[:description])
            .and include('parent_category_id' => parent_category.id)
        end
      end
    end
  end
end
