module Jwt
  class Refresher
    def initialize(refresh_token, headers)
      @refresh_token = refresh_token
      @headers = headers
    end

    def call
      user, token = Jwt::Authenticator.new(@headers).call
      raise Jwt::Errors::InvalidRefreshToken unless user.refresh_token

      token.update(status: :revoked)
      Jwt::Issuer.new(user).call
    end
  end
end
