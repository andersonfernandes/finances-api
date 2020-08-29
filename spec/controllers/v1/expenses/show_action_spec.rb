require 'rails_helper'

RSpec.describe V1::ExpensesController, '#show', type: :request do
  let(:user) { create(:user) }
  let(:expense) { create(:expense, user: user) }

  let(:headers) { authorization_header(user.id) }

  before { get v1_expense_path(expense), headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the expense exists' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(response_body).to include('id' => expense.id)
          .and include('description' => expense.description)
          .and include('amount' => expense.amount.to_s)
          .and include('spent_on' => expense.spent_on.to_time.iso8601)
          .and include('payment_method' => expense.payment_method)
          .and include('category' => expense.category.to_response)
      end
    end

    context 'and the category does not exist' do
      let(:expense) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find Expense with 'id'=-1"
        expect(response_body).to include('errors' => error_message)
      end
    end
  end
end
