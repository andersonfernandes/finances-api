module V1
  class AccountsController < ApplicationController
    before_action :set_account, only: :show

    resource_description do
      short 'Accounts Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      error code: 404, desc: 'Not Found'
      error code: 422, desc: 'Unprocessable Entity'
      formats ['json']
    end

    def_param_group :account do
      property :id, :number, desc: 'Account id'
      property :description, String, desc: 'Account description'
      property :financial_institution,
               String, desc: 'Account related financial_institution'
      property :initial_amount, :decimal, desc: 'Account initial amount'
      property :account_type, Account.account_types.keys
    end

    api :GET, '/v1/accounts', 'List all user accounts'
    returns array_of: :account, code: 200, desc: 'Successful response'
    def index
      accounts = Account.where(user_id: current_user.id)

      render json: accounts.map(&:to_response), status: :ok
    end

    api :GET, '/v1/accounts/:id', 'Returns an account'
    param :id, :number, desc: 'Transaction id'
    returns code: 200, desc: 'Successful response' do
      param_group :account
    end
    def show
      render json: @account.to_response, status: :ok
    end

    private

    def set_account
      @account = Account.find(params[:id])
    end
  end
end
