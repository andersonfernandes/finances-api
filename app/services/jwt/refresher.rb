module Jwt
  class Refresher
    def initialize(refresh_token, access_token)
      @refresh_token = refresh_token
      @access_token = access_token
    end

    def call
      user, token = Jwt::Authenticator.new.call(@access_token)
      raise Jwt::Errors::InvalidRefreshToken unless user.refresh_token

      token.update(status: :revoked)
      Jwt::Issuer.new.call(user)
    end
  end
end
