# frozen_string_literal: true
class ParkingsController < ApplicationController

  rescue_from ActionController::ParameterMissing do |e|
    render json: {errors: [e.message]}, status: :bad_request
  end

  def create
    parking = Parkings::Creator.call(plate)

    if parking
      render json: ParkingSerializer.new(parking), status: :created
    else
      render status: :unprocessable_entity
    end
  end

  private

  def plate
    params.require(:plate)
  end
end
