module Jwt
  class Decoder
    def call(access_token, verify_expiration: true)
      decoded = JWT.decode(
        access_token,
        Figaro.env.secret_key_base,
        verify_expiration
      ).first

      decoded.symbolize_keys
    rescue JWT::ExpiredSignature
      raise Jwt::Errors::ExpiredToken
    rescue JWT::DecodeError
      raise Jwt::Errors::InvalidToken
    end
  end
end
