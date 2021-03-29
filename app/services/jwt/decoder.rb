module Jwt
  class Decoder
    def call(access_token)
      decoded = JWT.decode(access_token, Figaro.env.secret_key_base)[0]

      decoded.symbolize_keys
    rescue JWT::ExpiredSignature
      raise Jwt::Errors::ExpiredToken
    rescue JWT::DecodeError
      raise Jwt::Errors::InvalidToken
    end
  end
end
