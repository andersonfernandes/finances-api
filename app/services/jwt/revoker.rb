module Jwt
  class Revoker
    def call(headers)
      user, token = Jwt::Authenticator.new(headers).call

      user.refresh_token.destroy
      token.revoked!
    rescue Jwt::Errors::RevokedToken
      true
    end
  end
end
