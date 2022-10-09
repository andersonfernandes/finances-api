module Jwt
  class Decoder
    def call(access_token, verify_expiration: true)
      raise Jwt::Errors::MissingToken unless access_token.present?

      decoded = JWT.decode(access_token, ENV['SECRET_KEY_BASE'], verify_expiration)
      decoded.first.symbolize_keys
    rescue JWT::ExpiredSignature
      raise Jwt::Errors::ExpiredToken
    rescue JWT::DecodeError
      raise Jwt::Errors::InvalidToken
    end
  end
end
