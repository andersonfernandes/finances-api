module V1
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    resource_description do
      short 'Authentication Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      formats ['json']
    end

    api :POST, '/v1/authenticate', 'Authenticates the user to the application'
    param :email, String, desc: 'User email', required: true
    param :password, String, desc: 'User password', required: true
    returns code: 200, desc: 'Successful response' do
      property :token, String, desc: 'Authenticated user token'
    end
    def authenticate
      command = ::Users::Authenticate.call(authenticate_params)

      if command.success?
        render json: { token: command.result }, status: :ok
      else
        message = 'Credentials were missing or incorrect'
        render json: { message: message }, status: :unauthorized
      end
    end

    private

    def authenticate_params
      params.permit(:email, :password)
    end
  end
end
