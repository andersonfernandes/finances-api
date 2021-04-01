module V1
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    resource_description do
      short 'Authentication Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      formats ['json']
    end

    api :POST, '/v1/auth/access_token', 'Issue a new access_token'
    param :email, String, desc: 'User email', required: true
    param :password, String, desc: 'User password', required: true
    returns code: 200, desc: 'Successful response' do
      property :access_token, String, desc: 'Authenticated user access token'
      property :refresh_token, String, desc: 'Authenticated user token refresh token'
    end
    def access_token
      user = authenticate_user

      if user
        issued_tokens = Jwt::Issuer.new.call(user)
        render json: issued_tokens, status: :ok
      else
        render error_response(:unauthorized)
      end
    end

    private

    def authenticate_user
      user = User.find_by_email(params[:email])
      return unless user&.authenticate(params[:password])

      user
    end
  end
end
