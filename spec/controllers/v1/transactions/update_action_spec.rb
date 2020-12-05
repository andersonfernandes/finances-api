require 'rails_helper'

RSpec.describe V1::TransactionsController, '#update',
               type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  let(:params) do
    {
      description: 'Cinema',
      amount: 25.0,
      spent_on: Date.today.to_time.iso8601,
      payment_method: 'money'
    }
  end
  let(:headers) { authorization_header(user.id) }

  before do
    put(v1_transaction_path(transaction), params: params, headers: headers)
  end

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the transaction belongs to the current user' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expected_category = {
          'id' => transaction.category_id,
          'description' => transaction.category_description,
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

    context 'and the transaction does not exist' do
      let(:transaction) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find Transaction with 'id'=-1"
        expect(body).to include('errors' => error_message)
      end
    end
  end
end
