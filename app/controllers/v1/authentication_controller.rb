module V1
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    resource_description do
      short 'Authentication Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      formats ['json']
    end

    api :POST, '/v1/auth/access_token', 'Issue a new set of access_token and refresh_token'
    param :email, String, desc: 'User email', required: true
    param :password, String, desc: 'User password', required: true
    returns code: 200, desc: 'Successful response' do
      property :access_token, String, desc: 'Authenticated user access token'
      property :refresh_token, String, desc: 'Authenticated user refresh token'
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

    api :POST, '/v1/auth/refresh_token', 'Re-issue a new set of access_token and refresh_token'
    param :refresh_token, String, desc: 'User refresh token', required: true
    header 'Authentication', 'User access token', required: true
    returns code: 200, desc: 'Successful response' do
      property :access_token, String, desc: 'New access token'
      property :refresh_token, String, desc: 'User refresh token'
    end
    def refresh_token
      new_tokens = Jwt::Refresher.new.call(
        params[:refresh_token],
        access_token_from_auth_header
      )

      render json: new_tokens, status: :ok
    end

    api :POST, '/v1/auth/revoke', 'Revoke the given access token'
    header 'Authentication', 'User access token', required: true
    returns code: 204, desc: 'Successful response'
    def revoke
      Jwt::Revoker.new.call(access_token_from_auth_header)
      render status: :no_content
    end

    private

    def authenticate_user
      user = User.find_by_email(params[:email])
      return unless user&.authenticate(params[:password])

      user
    end
  end
end
