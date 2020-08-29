require 'rails_helper'

RSpec.describe V1::CategoriesController, '#show', type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  let(:headers) { authorization_header(user.id) }

  before { get v1_category_path(category), headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the category exists' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(response_body).to include('description' => category.description)
          .and include('id' => category.id)
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
  end
end
