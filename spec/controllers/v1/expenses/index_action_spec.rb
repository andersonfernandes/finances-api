require 'rails_helper'

RSpec.describe V1::ExpensesController, '#index', type: :request do
  let(:user_01) { create(:user) }
  let(:user_02) { create(:user) }
  let!(:expense_01) { create(:expense, user: user_01) }
  let!(:expense_02) { create(:expense, user: user_02) }
  let!(:expense_03) { create(:expense, user: user_01) }

  let(:headers) { authorization_header(user_01.id) }

  before { get v1_expenses_path, headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'when have 3 expenses and 2 belongs to the user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body.size).to eq 2 }
      it do
        expect(response_body.first).to include('id' => expense_01.id)
          .and include('description' => expense_01.description)
          .and include('amount' => expense_01.amount.to_s)
          .and include('spent_on' => expense_01.spent_on.to_time.iso8601)
          .and include('payment_method' => expense_01.payment_method)
          .and include('category' => expense_01.category.to_response)

        expect(response_body.second).to include('id' => expense_03.id)
          .and include('description' => expense_03.description)
          .and include('amount' => expense_03.amount.to_s)
          .and include('spent_on' => expense_03.spent_on.to_time.iso8601)
          .and include('payment_method' => expense_03.payment_method)
          .and include('category' => expense_03.category.to_response)
      end
    end
  end
end
