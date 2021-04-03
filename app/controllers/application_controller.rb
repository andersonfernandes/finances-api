class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  rescue_from Jwt::Errors::InvalidToken do
    render error_response(:unauthorized)
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render error_response(:not_found, e.message)
  end

  rescue_from Apipie::ParamMissing,
              Jwt::Errors::MissingToken,
              Jwt::Errors::MissingRefreshToken do |e|
    render error_response(:bad_request, e.message)
  end

  rescue_from Apipie::ParamInvalid do |e|
    render error_response(:unprocessable_entity, e.message)
  end

  def error_response(http_error, errors = {})
    template = error_template(http_error, errors)
    return { json: {}, status: :internal_server_error } if template.nil?

    { json: template, status: http_error }
  end

  private

  def authenticate_request
    @current_user, = Jwt::Authenticator.new.call(access_token_from_auth_header)
  end

  def access_token_from_auth_header
    request.headers.fetch('Authorization', '').split(' ').last
  end

  def error_template(http_error, errors)
    templates = {
      bad_request: { message: 'Bad Request', errors: errors },
      unauthorized: { message: 'Unauthorized' },
      not_found: { message: 'Not Found', errors: errors },
      unprocessable_entity: { message: 'Unprocessable Entity', errors: errors }
    }
    templates[http_error]
  end
end
