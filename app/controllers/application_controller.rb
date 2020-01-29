class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |e|
    render json: {errors: [e.message]}, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {errors: [e.message]}, status: :not_found
  end
end
