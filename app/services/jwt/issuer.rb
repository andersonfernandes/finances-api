module Jwt
  class Issuer
    def initialize(user)
      @user = user
    end

    def call
      {
        refresh_token: refresh_token
      }
    end

    private

    def refresh_token
      return @user.refresh_token.token if @user.refresh_token

      create_refresh_token.token
    end

    def create_refresh_token
      @user.create_refresh_token(
        token: Digest::SHA256.hexdigest(SecureRandom.hex),
        status: :active
      )
    end
  end 
end
