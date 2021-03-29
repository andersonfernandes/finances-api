module Jwt
  module Errors
    class InvalidToken < StandardError; end
    class MissingToken < StandardError ;end
    class ExpiredToken < StandardError ;end
  end 
end
