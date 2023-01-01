require 'rails_helper'

RSpec.describe V1::TransactionsController, '#update', type: :request do
  let(:setup) {}
  let(:body) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  let(:params) do
    {
      description: 'Cinema',
      amount: 25.0,
      recurrent: true,
      paid_at: Date.today.to_time.iso8601,
      expires_at: Date.tomorrow.to_time.iso8601
    }
  end
  let(:headers) { authorization_header(user) }

  before do
    setup
    put v1_transaction_path(transaction), params: params, headers: headers
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
          .and include('paid_at' => params[:paid_at])
          .and include('recurrent' => params[:recurrent])
          .and include('expires_at' => params[:expires_at])
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

    context 'and the update action fails' do
      let(:setup) { allow_any_instance_of(Transaction).to receive(:update).and_return(false) }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body).to include('message' => 'Unprocessable Entity')
      end
    end
  end
end
