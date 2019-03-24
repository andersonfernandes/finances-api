class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  rescue_from Apipie::ParamMissing do |e|
    render json: e.message, status: :bad_request
  end

  rescue_from Apipie::ParamInvalid do |e|
    render json: e.message, status: :unprocessable_entity
  end

  private

  def authenticate_request
    @current_user = Users::Authorize.call(request.headers).result
    render json: { message: 'Unauthorized' }, status: 401 unless @current_user
  end
end
