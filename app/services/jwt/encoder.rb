module Jwt
  class Encoder
    def call(user)
      token = create_token(user)
      encode_access_token(token)
    end

    private

    TOKEN_EXPIRY_AT = 24.hours.from_now

    def encode_access_token(token)
      JWT.encode(
        token.access_token_payload,
        Figaro.env.secret_key_base
      )
    end

    def create_token(user)
      Token.create!(
        jwt_id: Digest::SHA256.hexdigest(SecureRandom.hex),
        status: :active,
        expiry_at: TOKEN_EXPIRY_AT,
        user: user
      )
    end
  end
end
