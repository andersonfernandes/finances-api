require 'rails_helper'

RSpec.describe V1::ExpensesController, '#create', type: :request do
  let(:setup) {}
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  let(:params) do
    {
      description: 'Super Market',
      amount: 12.5,
      spent_on: Date.today.to_time.iso8601,
      payment_method: 'debit',
      category_id: category.id
    }
  end
  let(:headers) { authorization_header(user.id) }

  before do
    setup
    post v1_expenses_path, params: params, headers: headers
  end

  context 'when the user is authenticated' do
    context 'with missing params' do
      let(:params) { {} }

      it { expect(response).to have_http_status(:bad_request) }
    end

    context 'with valid params' do
      it { expect(response).to have_http_status(:created) }
      it do
        expected_category = {
          'id' => category.id,
          'description' => category.description,
          'parent_category_id' => nil,
          'child_categories' => []
        }
        expect(response_body).to include('description' => params[:description])
          .and include('amount' => params[:amount].to_s)
          .and include('spent_on' => params[:spent_on])
          .and include('payment_method' => params[:payment_method])
          .and include('category' => expected_category)
      end
    end
  end

  context 'when the user is not authenticated' do
    let(:headers) { {} }
    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(response_body).to include('message' => 'Unauthorized') }
  end
end
