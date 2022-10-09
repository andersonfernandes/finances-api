require 'rails_helper'

RSpec.describe V1::CategoriesController, '#index', type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:category1) { create(:category, user: user1) }
  let!(:category2) { create(:category, user: user2) }
  let!(:category3) { create(:category, user: user1) }

  let(:headers) { authorization_header(user1) }

  before { get v1_categories_path, headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'when have 3 categories and 2 belongs to the user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body.size).to eq 2 }
      it do
        expect(response_body.first)
          .to include('description' => category1.description)

        expect(response_body.second)
          .to include('description' => category3.description)
      end
    end
  end
end
