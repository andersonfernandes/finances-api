class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  rescue_from Apipie::ParamMissing do |e|
    render error_response(:bad_request, e.message)
  end

  rescue_from Apipie::ParamInvalid do |e|
    render error_response(:unprocessable_entity, e.message)
  end

  def error_response(http_error, errors = {})
    template = error_template(http_error, errors)

    response_with_template  = { json: template, status: http_error }
    internal_server_error   = { json: {}, status: :internal_server_error }

    template.nil? ? internal_server_error : response_with_template
  end

  private

  def authenticate_request
    @current_user = Users::Authorize.call(request.headers).result
    render error_response(:unauthorized) unless @current_user
  end

  def error_template(http_error, errors)
    templates = {
      bad_request: { message: 'Bad Request', errors: errors },
      unauthorized: { message: 'Unauthorized' },
      unprocessable_entity: { message: 'Unprocessable Entity', errors: errors }
    }
    templates[http_error]
  end
end
