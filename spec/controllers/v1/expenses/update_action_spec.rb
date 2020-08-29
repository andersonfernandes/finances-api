require 'rails_helper'

RSpec.describe V1::ExpensesController, '#update', type: :request do
  let(:user) { create(:user) }
  let(:expense) { create(:expense, user: user) }

  let(:params) do
    {
      description: 'Cinema',
      amount: 25.0,
      spent_on: Date.today.to_time.iso8601,
      payment_method: 'money'
    }
  end
  let(:headers) { authorization_header(user.id) }

  before { put v1_expense_path(expense), params: params, headers: headers }

  context 'when the user is authenticated' do
    context 'and the expense belongs to the current user' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expected_category = {
          'id' => expense.category_id,
          'description' => expense.category_description,
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

    context 'and the expense does not exist' do
      let(:expense) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find Expense with 'id'=-1"
        expect(response_body).to include('errors' => error_message)
      end
    end
  end

  context 'when the user is not authenticated' do
    let(:headers) { {} }
    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(response_body).to include('message' => 'Unauthorized') }
  end
end
