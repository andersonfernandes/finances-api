require 'rails_helper'

RSpec.describe V1::TransactionsController, '#show',
               type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  let(:headers) { authorization_header(user.id) }

  before { get v1_transaction_path(transaction), headers: headers }

  context 'when the user is authenticated' do
    context 'and the transaction exists' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(body).to include('id' => transaction.id)
          .and include('description' => transaction.description)
          .and include('amount' => transaction.amount.to_s)
          .and include('spent_on' => transaction.spent_on.to_time.iso8601)
          .and include('payment_method' => transaction.payment_method)
          .and include('category' => transaction.category.to_response)
      end
    end

    context 'and the category does not exist' do
      let(:transaction) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find Transaction with 'id'=-1"
        expect(body).to include('errors' => error_message)
      end
    end
  end

  context 'when the user is not authenticated' do
    let(:headers) { {} }
    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(body).to include('message' => 'Unauthorized') }
  end
end
