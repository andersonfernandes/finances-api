module Jwt
  module Errors
    class InvalidToken < StandardError
      def message
        'Invalid Access Token'
      end

      def error_identifier
        'invalid_token'
      end
    end

    class ExpiredToken < StandardError
      def message
        'Expired Access Token'
      end

      def error_identifier
        'expired_token'
      end
    end

    class RevokedToken < StandardError
      def message
        'Revoked Access Token'
      end

      def error_identifier
        'revoked_token'
      end
    end

    class MissingToken < StandardError
      def message
        'Missing Access Token'
      end

      def error_identifier
        'invalid_token'
      end
    end

    class MissingRefreshToken < StandardError
      def message
        'Missing Refresh Token'
      end
    end
  end
end
