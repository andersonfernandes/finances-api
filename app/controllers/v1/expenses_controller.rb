module V1
  class ExpensesController < ApplicationController
    before_action :set_expense, only: %i[show]

    resource_description do
      short 'Expenses Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      error code: 404, desc: 'Not Found'
      error code: 422, desc: 'Unprocessable Entity'
      formats ['json']
    end

    def_param_group :expense do
      property :id, :number
      property :description, String, desc: 'Expense description'
      property :amount, :decimal, desc: 'Amount spent'
      property(:spent_on,
               :iso8601_date,
               desc: 'Date in ISO-8601 format',
               base_class: Date)
      property :payment_method, Expense.payment_methods.keys
      property :category, Hash do
        property :id, :number, desc: 'Category id'
        property :description, String, desc: 'Category description'
      end
    end

    api :POST, '/v1/expenses', 'Creates a expense'
    param :description, String, desc: 'Expense description', required: true
    param :amount, :decimal, desc: 'Amount spent', required: true
    param(:spent_on,
          :iso8601_date,
          desc: 'Date in ISO-8601 format',
          required: true,
          base_class: Date)
    param :payment_method, Expense.payment_methods.keys, required: true
    param :category_id, :number, required: true
    returns code: 201, desc: 'Successful response' do
      param_group :expense
    end
    def create
      expense = Expense.new(expense_params)

      if expense.save
        render json: expense.to_response, status: :created
      else
        render error_response(:unprocessable_entity, expense.errors.messages)
      end
    end

    api :GET, '/v1/expenses/:id', 'Returns a category'
    returns code: 200, desc: 'Successful response' do
      param_group :expense
    end
    def show
      render json: @expense.to_response, status: :ok
    end

    private

    def expense_params
      params
        .permit(%i[description amount spent_on payment_method category_id])
        .merge(user_id: current_user.id)
    end

    def set_expense
      @expense = Expense.find(params[:id])
    end
  end
end
