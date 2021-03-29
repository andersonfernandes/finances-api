module Jwt
  module Errors
    class InvalidToken < StandardError; end
    class MissingToken < StandardError; end
    class ExpiredToken < StandardError; end
    class RevokedToken < StandardError; end
    class InvalidRefreshToken < StandardError; end
  end
end
