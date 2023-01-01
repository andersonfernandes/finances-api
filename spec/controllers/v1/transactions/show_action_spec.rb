require 'rails_helper'

RSpec.describe V1::TransactionsController, '#show', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  let(:headers) { authorization_header(user) }

  before { get v1_transaction_path(transaction), headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the transaction exists' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(body).to include('id' => transaction.id)
          .and include('description' => transaction.description)
          .and include('amount' => transaction.amount.to_s)
          .and include('recurrent' => transaction.recurrent)
          .and include('paid_at' => transaction.paid_at.to_time.iso8601)
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
end
