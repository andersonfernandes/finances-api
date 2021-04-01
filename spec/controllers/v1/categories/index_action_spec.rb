require 'rails_helper'

RSpec.describe V1::CategoriesController, '#index', type: :request do
  let(:user_01) { create(:user) }
  let(:user_02) { create(:user) }
  let!(:category_01) { create(:category, user: user_01) }
  let!(:category_02) { create(:category, user: user_02) }
  let!(:category_03) { create(:category, user: user_01) }

  let(:headers) { authorization_header(user_01) }

  before { get v1_categories_path, headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'when have 3 categories and 2 belongs to the user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body.size).to eq 2 }
      it do
        expect(response_body.first)
          .to include('description' => category_01.description)

        expect(response_body.second)
          .to include('description' => category_03.description)
      end
    end
  end
end
