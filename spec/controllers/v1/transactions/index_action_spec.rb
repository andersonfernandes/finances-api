require 'rails_helper'

RSpec.describe V1::TransactionsController, '#index',
               type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:user_01) { create(:user) }
  let(:user_02) { create(:user) }
  let!(:transaction_01) { create(:transaction, user: user_01) }
  let!(:transaction_02) { create(:transaction, user: user_02) }
  let!(:transaction_03) { create(:transaction, user: user_01) }

  let(:headers) { authorization_header(user_01.id) }

  before { get v1_transactions_path, headers: headers }

  context 'when the user is authenticated' do
    context 'when have 3 transactions and 2 belongs to the user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(body.size).to eq 2 }
      it do
        expect(body.first).to include('id' => transaction_01.id)
          .and include('description' => transaction_01.description)
          .and include('amount' => transaction_01.amount.to_s)
          .and include('spent_on' => transaction_01.spent_on.to_time.iso8601)
          .and include('payment_method' => transaction_01.payment_method)
          .and include('category' => transaction_01.category.to_response)

        expect(body.second).to include('id' => transaction_03.id)
          .and include('description' => transaction_03.description)
          .and include('amount' => transaction_03.amount.to_s)
          .and include('spent_on' => transaction_03.spent_on.to_time.iso8601)
          .and include('payment_method' => transaction_03.payment_method)
          .and include('category' => transaction_03.category.to_response)
      end
    end
  end

  context 'when the user is not authenticated' do
    let(:headers) { {} }
    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(body).to include('message' => 'Unauthorized') }
  end
end
