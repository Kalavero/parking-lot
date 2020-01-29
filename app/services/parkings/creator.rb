# frozen_string_literal: true
module Parkings
  class Creator < ApplicationService
    def initialize(plate)
      @plate = plate
    end

    def call
      parking = Parking.new(plate: @plate, checkin: Time.current)

      return false unless parking.save

      parking
    end
  end
end
