module V1
  class AuthenticationController < ApplicationController
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
