module Jwt
  class Issuer
    def call(user)
      {
        access_token: access_token(user),
        refresh_token: refresh_token(user)
      }
    end

    private

    def access_token(user)
      Jwt::Encoder.new.call(user)
    end

    def refresh_token(user)
      return user.refresh_token.encrypted_token if user.refresh_token

      refresh_token = user.create_refresh_token
      refresh_token.encrypted_token
    end
  end
end
