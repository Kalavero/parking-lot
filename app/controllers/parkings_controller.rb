# frozen_string_literal: true
class ParkingsController < ApplicationController
  before_action :set_parking, only: [:out, :pay]

  def create
    parking = Parkings::Creator.call(plate)

    if parking
      render json: ParkingSerializer.new(parking), status: :created
    else
      head :unprocessable_entity
    end
  end

  def pay
    parking = Parkings::Pay.call(@parking)

    render json: ParkingSerializer.new(parking), status: :ok
  end

  def out
    parking = Parkings::Checkout.call(@parking)

    if parking
      render json: ParkingSerializer.new(parking), status: :ok
    else
      render json: {errors: ['parking not paid']}, status: :unprocessable_entity
    end
  end

  def history
    parkings = Parking.where(plate: params[:plate])

    render json: ParkingSerializer.new(parkings)
  end

  private

  def plate
    params.require(:plate)
  end

  def set_parking
    @parking = Parking.find(params[:id])
  end
end
