module Jwt
  class Encoder
    def call(user)
      token = create_token(user)
      encode_access_token(token)
    end

    private

    def encode_access_token(token)
      JWT.encode(
        token.access_token_payload,
        ENV['SECRET_KEY_BASE']
      )
    end

    def create_token(user)
      Token.create!(
        jwt_id: Digest::SHA256.hexdigest(SecureRandom.hex),
        status: :active,
        expiry_at: 2.hours.from_now,
        user: user
      )
    end
  end
end
