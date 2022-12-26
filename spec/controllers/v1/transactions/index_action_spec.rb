require 'rails_helper'

RSpec.describe V1::TransactionsController, '#index', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:transaction1) { create(:transaction, account: create(:account, user: user1)) }
  let!(:transaction2) { create(:transaction, account: create(:account, user: user2)) }
  let!(:transaction3) { create(:transaction, account: create(:account, user: user1)) }

  let(:headers) { authorization_header(user1) }

  before { get v1_transactions_path, headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'when have 3 transactions and 2 belongs to the user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(body.size).to eq 2 }
      it do
        expect(body.first).to include('id' => transaction1.id)
          .and include('description' => transaction1.description)
          .and include('amount' => transaction1.amount.to_s)
          .and include('recurrent' => transaction1.recurrent)
          .and include('paid_at' => transaction1.paid_at.to_time.iso8601)
          .and include('category' => transaction1.category.to_response)
          .and include('account' => transaction1.account.to_response)

        expect(body.second).to include('id' => transaction3.id)
          .and include('description' => transaction3.description)
          .and include('amount' => transaction3.amount.to_s)
          .and include('recurrent' => transaction3.recurrent)
          .and include('paid_at' => transaction3.paid_at.to_time.iso8601)
          .and include('category' => transaction3.category.to_response)
          .and include('account' => transaction3.account.to_response)
      end
    end
  end
end
