module V1
  class CreditCardsController < ApplicationController
    include Api::V1::Resource
    include Api::V1::CreditCard::Request
    include Api::V1::CreditCard::Response

    before_action :set_credit_card, only: %i[show update destroy]

    api :GET, '/v1/credit_cards', 'List all credit cards associated with the current user'
    header 'Authentication', 'User access token', required: true
    returns array_of: :credit_card_response, code: 200, desc: 'Successful response'
    def index
      credit_cards = all_credit_cards

      render json: credit_cards.map(&:to_response)
    end

    api :GET, '/v1/credit_cards/:id', 'Returns a Credit Card'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Credit Card id'
    returns code: 200, desc: 'Successful response' do
      param_group :credit_card_response
    end
    def show
      render json: @credit_card.to_response, status: :ok
    end

    api :POST, '/v1/credit_cards', 'Creates a Credit Card'
    header 'Authentication', 'User access token', required: true
    param_group :create_credit_card_request
    returns code: 201, desc: 'Successful response' do
      param_group :credit_card_response
    end
    def create
      credit_card = CreditCard.new(credit_card_params)
      credit_card.account = create_account

      if credit_card.save
        render json: credit_card.to_response, status: :created
      else
        render error_response(:unprocessable_entity, credit_card.errors.messages)
      end
    end

    api :PUT, '/v1/credit_cards/:id', 'Updates a Credit Card'
    header 'Authentication', 'User access token', required: true
    param_group :update_credit_card_request
    returns code: 200, desc: 'Successful response' do
      param_group :credit_card_response
    end
    def update
      if @credit_card.update(credit_card_params)
        @credit_card.account.update(financial_institution_id: params[:financial_institution_id])

        render json: @credit_card.to_response, status: :ok
      else
        render error_response(:unprocessable_entity, @credit_card.errors.messages)
      end
    end

    api :DELETE, '/v1/credit_cards/:id', 'Delete a Credit Card'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Credit Card id'
    returns code: 204, desc: 'Successful response'
    def destroy
      if @credit_card.destroy
        render json: {}, status: :no_content
      else
        render error_response(:unprocessable_entity, @credit_card.errors.messages)
      end
    end

    private

    def credit_card_params
      params.permit(:closing_day, :due_day, :limit, :name)
    end

    def set_credit_card
      @credit_card = CreditCard.find(params[:id])
    end

    def create_account
      Account.create(
        account_type: :credit_card,
        financial_institution_id: params[:financial_institution_id],
        user_id: current_user.id
      )
    end

    def all_credit_cards
      CreditCard
        .joins(:account)
        .includes(account: :financial_institution)
        .where(accounts: { user_id: current_user.id })
    end
  end
end
