require 'rails_helper'

RSpec.describe V1::TransactionsController, '#create',
               type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:setup) {}
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let(:account) { create(:account, user: user) }

  let(:params) do
    {
      description: 'Super Market',
      amount: 12.5,
      spent_at: Date.today.to_time.iso8601,
      transaction_type: 'expense',
      category_id: category.id,
      account_id: account.id
    }
  end
  let(:headers) { authorization_header(user.id) }

  before do
    setup
    post v1_transactions_path, params: params, headers: headers
  end

  include_context 'when the user is not authenticated'

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
        expected_account = {
          'id' => account.id,
          'name' => account.name,
          'description' => account.description,
          'financial_institution' => {
            'name' => account.financial_institution_name,
            'logo_url' => account.financial_institution_logo_url
          },
          'initial_amount' => account.initial_amount.to_s,
          'account_type' => account.account_type
        }
        expect(response_body).to include('description' => params[:description])
          .and include('amount' => params[:amount].to_s)
          .and include('spent_at' => params[:spent_at])
          .and include('transaction_type' => params[:transaction_type])
          .and include('category' => expected_category)
          .and include('account' => expected_account)
      end
    end
  end
end
