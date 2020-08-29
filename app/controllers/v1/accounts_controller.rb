module V1
  class AccountsController < ApplicationController
    def index
      accounts = Account.where(user_id: current_user.id)

      render json: accounts.map(&:to_response), status: :ok
    end
  end
end
