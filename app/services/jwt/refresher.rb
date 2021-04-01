module Jwt
  class Refresher
    def call(refresh_token, access_token)
      user, token = Jwt::Authenticator.new.call(access_token)
      raise Jwt::Errors::InvalidRefreshToken unless user.refresh_token

      token.update(status: :revoked)
      Jwt::Issuer.new.call(user)
    end
  end
end
