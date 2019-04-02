module V1
  class ExpensesController < ApplicationController
    before_action :set_expense, only: %i[show update destroy]

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

    api :GET, '/v1/expenses', 'List all expenses'
    returns array_of: :expense, code: 200, desc: 'Successful response'
    def index
      expenses = Expense.where(user_id: current_user.id)

      render json: expenses.map(&:to_response), status: :ok
    end

    api :GET, '/v1/expenses/:id', 'Returns a category'
    returns code: 200, desc: 'Successful response' do
      param_group :expense
    end
    def show
      render json: @expense.to_response, status: :ok
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

    api :PUT, '/v1/expenses/:id', 'Updates a expense'
    param :description, String, desc: 'Expense description', required: false
    param :amount, :decimal, desc: 'Amount spent', required: false
    param(:spent_on,
          :iso8601_date,
          desc: 'Date in ISO-8601 format',
          required: false,
          base_class: Date)
    param :payment_method, Expense.payment_methods.keys, required: false
    param :category_id, :number, required: false
    returns code: 200, desc: 'Successful response' do
      param_group :expense
    end
    def update
      if @expense.update(expense_params)
        render json: @expense.to_response, status: :ok
      else
        render error_response(:unprocessable_entity, @expense.errors.messages)
      end
    end

    api :DELETE, '/v1/expenses/:id', 'Delete a expense'
    returns code: 204, desc: 'Successful response'
    def destroy
      if @expense.destroy
        render json: {}, status: :no_content
      else
        render error_response(:unprocessable_entity, @expense.errors.messages)
      end
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
