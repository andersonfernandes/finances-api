module V1
  class UsersController < ApplicationController
    include Api::V1::Resource
    include Api::V1::User::Response

    api :GET, '/v1/users/me', 'List current user details'
    header 'Authentication', 'User access token', required: true
    returns :user_response, code: 200, desc: 'Successful response'
    def me
      render json: {
        name: current_user.name,
        email: current_user.email,
        default_account: current_user.default_account&.to_response
      }, status: :ok
    end
  end
end
