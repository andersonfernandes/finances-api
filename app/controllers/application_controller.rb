class ApplicationController < ActionController::API
  rescue_from Apipie::ParamMissing do |e|
    render json: e.message, status: :bad_request
  end

  rescue_from Apipie::ParamInvalid do |e|
    render json: e.message, status: :unprocessable_entity
  end
end
