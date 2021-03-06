module V1
  class TransactionsController < ApplicationController
    before_action :set_transaction, only: %i[show update destroy]

    resource_description do
      short 'Transactions Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      error code: 404, desc: 'Not Found'
      error code: 422, desc: 'Unprocessable Entity'
      formats ['json']
    end

    def_param_group :transaction do
      property :id, :number, desc: 'Transaction id'
      property :description, String, desc: 'Transaction description'
      property :amount, :decimal, desc: 'Amount spent'
      property(:spent_at,
               :iso8601_date,
               desc: 'Date in ISO-8601 format',
               base_class: Date)
      property :transaction_type, Transaction.transaction_types.keys
      property :category, Hash do
        property :id, :number, desc: 'Category id'
        property :description, String, desc: 'Category description'
      end
      property :account, Hash do
        property :id, :number, desc: 'Account id'
        property :name, String, desc: 'Account name'
      end
    end

    api :GET, '/v1/transactions', 'List all transactions'
    returns array_of: :transaction, code: 200, desc: 'Successful response'
    def index
      transactions = Transaction.joins(account: :user).where(accounts: { user_id: current_user.id })

      render json: transactions.map(&:to_response), status: :ok
    end

    api :GET, '/v1/transactions/:id', 'Returns a transaction'
    param :id, :number, desc: 'Transaction id'
    returns code: 200, desc: 'Successful response' do
      param_group :transaction
    end
    def show
      render json: @transaction.to_response, status: :ok
    end

    api :POST, '/v1/transactions', 'Creates a transaction'
    param :description, String, desc: 'Transaction description', required: true
    param :amount, :decimal, desc: 'Amount spent', required: true
    param(:spent_at,
          :iso8601_date,
          desc: 'Date in ISO-8601 format',
          required: true,
          base_class: Date)
    param :transaction_type, Transaction.transaction_types.keys, required: true
    param :category_id, :number, required: true
    param :account_id, :number, required: true
    returns code: 201, desc: 'Successful response' do
      param_group :transaction
    end
    def create
      transaction = Transaction.new(transaction_params)

      if transaction.save
        render json: transaction.to_response, status: :created
      else
        render error_response(
          :unprocessable_entity,
          transaction.errors.messages
        )
      end
    end

    api :PUT, '/v1/transactions/:id', 'Updates a transaction'
    param :id, :number, desc: 'Transaction id'
    param :description, String, desc: 'Transaction description',
                                required: false, default_value: nil
    param :amount, :decimal, desc: 'Amount spent',
                             required: false,
                             default_value: nil
    param :spent_at, :iso8601_date, desc: 'Date in ISO-8601 format',
                                    required: false,
                                    base_class: Date,
                                    default_value: nil
    param :transaction_type, Transaction.transaction_types.keys, required: false,
                                                                 default_value: nil
    param :category_id, :number, required: false, default_value: nil
    returns code: 200, desc: 'Successful response' do
      param_group :transaction
    end
    def update
      if @transaction.update(transaction_params)
        render json: @transaction.to_response, status: :ok
      else
        render error_response(
          :unprocessable_entity,
          @transaction.errors.messages
        )
      end
    end

    api :DELETE, '/v1/transactions/:id', 'Delete a transaction'
    param :id, :number, desc: 'Transaction id'
    returns code: 204, desc: 'Successful response'
    def destroy
      if @transaction.destroy
        render json: {}, status: :no_content
      else
        render error_response(
          :unprocessable_entity,
          @transaction.errors.messages
        )
      end
    end

    private

    def transaction_params
      params.permit(%i[description amount spent_at transaction_type category_id account_id])
    end

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
  end
end
