class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  rescue_from Jwt::Errors::InvalidToken,
              Jwt::Errors::MissingToken,
              Jwt::Errors::ExpiredToken,
              Jwt::Errors::RevokedToken do |error|
    response.headers['WWW-Authenticate'] = build_authenticate_header(error)
    render error_response(:unauthorized, error.message)
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    render error_response(:not_found, error.message)
  end

  rescue_from Apipie::ParamMissing, Jwt::Errors::MissingRefreshToken do |error|
    render error_response(:bad_request, error.message)
  end

  rescue_from Apipie::ParamInvalid do |error|
    render error_response(:unprocessable_entity, error.message)
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

  def build_authenticate_header(error)
    error_identifier = error&.error_identifier || 'invalid_token'
    header_signature = [
      "Bearer realm=\"#{request.base_url}\"",
      "error=\"#{error_identifier}\"",
      "error_description=\"#{error.message}\""
    ]

    header_signature.join(', ')
  end

  def error_template(http_error, errors)
    templates = {
      bad_request: { message: 'Bad Request', errors: errors },
      unauthorized: { message: 'Unauthorized', errors: errors },
      not_found: { message: 'Not Found', errors: errors },
      unprocessable_entity: { message: 'Unprocessable Entity', errors: errors }
    }
    templates[http_error]
  end
end
