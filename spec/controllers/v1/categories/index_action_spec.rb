require 'rails_helper'

RSpec.describe V1::CategoriesController, '#create',
               type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:user_01) { create(:user) }
  let(:user_02) { create(:user) }
  let!(:category_01) { create(:category, user: user_01) }
  let!(:category_02) { create(:category, user: user_02) }
  let!(:category_03) { create(:category, user: user_01) }

  let(:headers) { authorization_header(user_01.id) }

  before { get v1_categories_path, headers: headers }

  context 'when the user is authenticated' do
    context 'when have 3 categories and 2 belongs to the user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(body.size).to eq 2 }
      it do
        expect(body.first)
          .to include('description' => category_01.description)

        expect(body.second)
          .to include('description' => category_03.description)
      end
    end
  end

  context 'when the user is not authenticated' do
    let(:headers) { {} }
    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(body).to include('message' => 'Unauthorized') }
  end
end
