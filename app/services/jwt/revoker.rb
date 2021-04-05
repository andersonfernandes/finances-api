module Jwt
  class Revoker
    def call(access_token)
      _, token = Jwt::Authenticator.new.call(access_token)

      token.revoked!
    rescue Jwt::Errors::RevokedToken
      true
    end
  end
end
