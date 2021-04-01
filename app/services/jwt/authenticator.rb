module Jwt
  class Authenticator
    def call(access_token)
      raise Jwt::Errors::MissingToken unless access_token

      decoded_token = Jwt::Decoder.new.call(access_token)
      authenticate_user_from_token(decoded_token)
    end

    private

    def authenticate_user_from_token(decoded_token)
      jwt_id = decoded_token[:jti]
      user_id = decoded_token[:user_id]
      raise Jwt::Errors::InvalidToken unless jwt_id.present? && user_id.present?

      token = Token.find_by(jwt_id: jwt_id)
      raise Jwt::Errors::RevokedToken if token.revoked?

      [User.find(user_id), token]
    end
  end
end
