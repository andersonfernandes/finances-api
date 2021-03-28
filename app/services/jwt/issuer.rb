module Jwt
  class Issuer
    def initialize(user)
      @user = user
    end

    def call
      {
        access_token: access_token,
        refresh_token: refresh_token
      }
    end

    private

    def access_token
      ::Jwt::Encoder.new(@user).call
    end

    def refresh_token
      return @user.refresh_token.encrypted_token if @user.refresh_token

      refresh_token = @user.create_refresh_token
      refresh_token.encrypted_token
    end
  end
end
