module Jwt
  class Refresher
    def call(refresh_token, access_token)
      user = user_by_refresh_token(refresh_token)
      token = token_by_access_token(access_token)

      token.update(status: :revoked)
      Jwt::Issuer.new.call(user)
    end

    private

    def user_by_refresh_token(refresh_token)
      refresh_token = RefreshToken.find_by(encrypted_token: refresh_token)&.user
      raise Jwt::Errors::InvalidRefreshToken unless refresh_token

      refresh_token
    end

    def token_by_access_token(access_token)
      decoded_access_token = Jwt::Decoder.new.call(access_token, verify_expiration: false)
      token = Token.find_by(jwt_id: decoded_access_token[:jti])

      raise Jwt::Errors::InvalidToken unless token
      raise Jwt::Errors::RevokedToken if token.revoked?

      token
    end
  end
end
