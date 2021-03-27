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

    ACCESS_TOKEN_EXPIRY = 2.hours.from_now.to_i

    def access_token
      payload = {
        exp: ACCESS_TOKEN_EXPIRY,
        user_id: @user.id
      }

      JWT.encode(payload, Figaro.env.secret_key_base)
    end

    def refresh_token
      return @user.refresh_token.encrypted_token if @user.refresh_token

      refresh_token = @user.create_refresh_token
      refresh_token.encrypted_token
    end
  end
end
