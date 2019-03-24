module V1
  class AuthenticationController < ApplicationController
    resource_description do
      short 'Authentication Actions'
      error code: 401, desc: "Unauthorized"
      error code: 400, desc: "Bad Request"
      formats ['json']
    end

    api :POST, '/v1/authenticate', 'Authenticates the user to the application'
    param :email, String, desc: "User email", required: true
    param :password, String, desc: "User password", required: true
    returns code: 200, desc: "Successful response" do
      property :data, Hash, desc: "Response data" do
        property :token, String, desc: "Authenticated user token"
      end
    end
    def authenticate
      command = ::Users::Authenticate.call(authenticate_params)

      if command.success?
        render json: { data: { token: command.result } }, status: :ok
      else
        render json: { errors: command.errors }, status: :unauthorized
      end
    end

    private

    def authenticate_params
      params.permit(:email, :password)
    end
  end
end
