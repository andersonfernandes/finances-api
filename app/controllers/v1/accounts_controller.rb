module V1
  class AccountsController < ApplicationController
    before_action :set_account, only: %i[show update destroy]

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
      property :name, String, desc: 'Account name'
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

    api :POST, '/v1/accounts', 'Creates a account'
    param :name, String, desc: 'Account name',
                         required: false,
                         default_value: nil
    param :description, String, desc: 'Account description',
                                required: false,
                                default_value: nil
    param :account_type, Account.account_types.keys, required: true
    param :financial_institution, String, desc: 'Account related financial_institution',
                                          required: true
    param :initial_amount, :decimal, desc: 'Account initial amount',
                                     required: true
    returns code: 201, desc: 'Successful response' do
      param_group :account
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
    param :id, :number, desc: 'Account id', required: true
    param :name, String, desc: 'Account name',
                         required: false,
                         default_value: nil
    param :description, String, desc: 'Account description',
                                required: false,
                                default_value: nil
    param :account_type, Account.account_types.keys, required: false,
                                                     default_value: nil
    param :financial_institution, String, desc: 'Account related financial_institution',
                                          required: false,
                                          default_value: false
    param :initial_amount, :decimal, desc: 'Account initial amount',
                                     required: false,
                                     default_value: nil
    returns code: 200, desc: 'Successful response' do
      param_group :account
    end
    def update
      if @account.update(account_params)
        render json: @account.to_response, status: :ok
      else
        render error_response(
          :unprocessable_entity,
          @account.errors.messages
        )
      end
    end

    api :DELETE, '/v1/accounts/:id', 'Delete a account'
    param :id, :number, desc: 'Account id'
    returns code: 204, desc: 'Successful response'
    def destroy
      if @account.destroy
        render json: {}, status: :no_content
      else
        render error_response(
          :unprocessable_entity,
          @account.errors.messages
        )
      end
    end

    private

    def account_params
      permitted = %i[description account_type financial_institution
                     initial_amount name]
      params.permit(permitted)
            .merge(user_id: current_user.id)
    end

    def set_account
      @account = Account.find(params[:id])
    end
  end
end
