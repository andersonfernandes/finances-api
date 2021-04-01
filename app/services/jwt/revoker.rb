module Jwt
  class Revoker
    def call(access_token)
      user, token = Jwt::Authenticator.new.call(access_token)

      user.refresh_token.destroy
      token.revoked!
    rescue Jwt::Errors::RevokedToken
      true
    end
  end
end
