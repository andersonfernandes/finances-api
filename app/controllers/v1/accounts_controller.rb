module V1
  class AccountsController < ApplicationController
    include Api::V1::Resource
    include Api::V1::Account::Request
    include Api::V1::Account::Response

    before_action :set_account, only: %i[show update destroy]

    api :GET, '/v1/accounts', 'List all user accounts'
    header 'Authentication', 'User access token', required: true
    returns array_of: :account_response, code: 200, desc: 'Successful response'
    def index
      accounts = all_accounts

      render json: accounts.map(&:to_response), status: :ok
    end

    api :GET, '/v1/accounts/:id', 'Returns an account'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Transaction id'
    returns code: 200, desc: 'Successful response' do
      param_group :account_response
    end
    def show
      render json: @account.to_response, status: :ok
    end

    api :POST, '/v1/accounts', 'Creates a account'
    header 'Authentication', 'User access token', required: true
    param_group :create_account_request
    returns code: 201, desc: 'Successful response' do
      param_group :account_response
    end
    def create
      account = Account.new(account_params)

      if account.save
        render json: account.to_response, status: :created
      else
        render error_response(:unprocessable_entity, account.errors.messages)
      end
    end

    api :PUT, '/v1/accounts/:id', 'Updates a account'
    header 'Authentication', 'User access token', required: true
    param_group :update_account_request
    returns code: 200, desc: 'Successful response' do
      param_group :account_response
    end
    def update
      if @account.update(account_params)
        render json: @account.to_response, status: :ok
      else
        render error_response(:unprocessable_entity, @account.errors.messages)
      end
    end

    api :DELETE, '/v1/accounts/:id', 'Delete a account'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Account id'
    returns code: 204, desc: 'Successful response'
    def destroy
      if @account.destroy
        render json: {}, status: :no_content
      else
        render error_response(:unprocessable_entity, @account.errors.messages)
      end
    end

    private

    def account_params
      permitted = %i[description account_type financial_institution_id initial_amount name]

      params.permit(permitted).merge(user_id: current_user.id)
    end

    def set_account
      @account = Account.find(params[:id])
    end

    def all_accounts
      Account
        .includes(:financial_institution)
        .where(user_id: current_user.id)
    end
  end
end
