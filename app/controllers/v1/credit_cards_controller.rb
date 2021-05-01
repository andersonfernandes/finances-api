module V1
  class CreditCardsController < ApplicationController
    include Api::V1::Resource
    include Api::V1::CreditCard::Request
    include Api::V1::CreditCard::Response

    api :GET, '/v1/credit_cards', 'List all credit cards associated with the current user'
    header 'Authentication', 'User access token', required: true
    returns array_of: :credit_card_response, code: 200, desc: 'Successful response'
    def index
      credit_cards = CreditCard.joins(:account).where(accounts: { user_id: current_user.id })

      render json: credit_cards.map(&:to_response)
    end
  end
end
