module Jwt
  class Authenticator
    def initialize(headers = {})
      @headers = headers
    end

    def call
      access_token = access_token_from_header
      decoded_token = Jwt::Decoder.new.call(access_token)

      authenticate_user_from_token(decoded_token)
    end

    private

    def access_token_from_header
      authorization_present = @headers['Authorization'].present?
      raise Jwt::Errors::MissingToken unless authorization_present

      @headers['Authorization'].split(' ').last
    end

    def authenticate_user_from_token(decoded_token)
      jwt_id = decoded_token[:jti]
      user_id = decoded_token[:user_id]
      raise Jwt::Errors::InvalidToken unless jwt_id.present? && user_id.present?

      token = Token.find_by(jwt_id: jwt_id)
      raise Jwt::Errors::RevokedToken if token.revoked?

      User.find(user_id)
    end
  end
end
