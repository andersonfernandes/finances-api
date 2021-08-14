module V1
  class TransactionsController < ApplicationController
    include Api::V1::Resource
    include Api::V1::Transaction::Request
    include Api::V1::Transaction::Response

    before_action :set_transaction, only: %i[show update destroy]

    api :GET, '/v1/transactions', 'List all transactions'
    header 'Authentication', 'User access token', required: true
    returns array_of: :transaction_response, code: 200, desc: 'Successful response'
    def index
      transactions = all_transactions

      render json: transactions.map(&:to_response), status: :ok
    end

    api :GET, '/v1/transactions/:id', 'Returns a transaction'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Transaction id'
    returns code: 200, desc: 'Successful response' do
      param_group :transaction_response
    end
    def show
      render json: @transaction.to_response, status: :ok
    end

    api :POST, '/v1/transactions', 'Creates a transaction'
    header 'Authentication', 'User access token', required: true
    param_group :create_transaction_request
    returns code: 201, desc: 'Successful response' do
      param_group :transaction_response
    end
    def create
      transaction = Transaction.new(transaction_params)

      if transaction.save
        render json: transaction.to_response, status: :created
      else
        render error_response(:unprocessable_entity, transaction.errors.messages)
      end
    end

    api :PUT, '/v1/transactions/:id', 'Updates a transaction'
    header 'Authentication', 'User access token', required: true
    param_group :update_transaction_request
    returns code: 200, desc: 'Successful response' do
      param_group :transaction_response
    end
    def update
      if @transaction.update(transaction_params)
        render json: @transaction.to_response, status: :ok
      else
        render error_response(:unprocessable_entity, @transaction.errors.messages)
      end
    end

    api :DELETE, '/v1/transactions/:id', 'Delete a transaction'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Transaction id'
    returns code: 204, desc: 'Successful response'
    def destroy
      if @transaction.destroy
        render json: {}, status: :no_content
      else
        render error_response(:unprocessable_entity, @transaction.errors.messages)
      end
    end

    private

    def transaction_params
      params.permit(%i[description amount spent_at transaction_type category_id account_id])
    end

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def all_transactions
      Transaction
        .includes(account: :financial_institution,
                  category: %i[child_categories parent_category])
        .joins(account: :user)
        .where(accounts: { user_id: current_user.id })
    end
  end
end
