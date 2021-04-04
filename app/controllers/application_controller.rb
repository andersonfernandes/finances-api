class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  rescue_from Jwt::Errors::InvalidToken,
              Jwt::Errors::MissingToken,
              Jwt::Errors::ExpiredToken,
              Jwt::Errors::RevokedToken do |e|
    response.headers['WWW-Authenticate'] = build_authenticate_header(e.class.to_s)
    render error_response(:unauthorized, e.message)
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render error_response(:not_found, e.message)
  end

  rescue_from Apipie::ParamMissing, Jwt::Errors::MissingRefreshToken do |e|
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

  def build_authenticate_header(error_class)
    header_signature = [
      "Bearer realm=\"#{request.base_url}\"",
      "error=\"#{header_signature_error(error_class)[:key]}\"",
      "error_description=\"#{header_signature_error(error_class)[:description]}\""
    ]

    header_signature.join(', ')
  end

  def header_signature_error(error_class)
    invalid_token_error = { key: 'invalid_token', description: 'Invalid access token' }
    expired_token_error = { key: 'expired_token', description: 'Access token expired' }
    revoked_token_error = { key: 'revoked_token', description: 'Access token revoked' }

    signature_error_by_class = {
      'Jwt::Errors::MissingToken' => invalid_token_error,
      'Jwt::Errors::InvalidToken' => invalid_token_error,
      'Jwt::Errors::ExpiredToken' => expired_token_error,
      'Jwt::Errors::RevokedToken' => revoked_token_error
    }

    signature_error_by_class[error_class]
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
