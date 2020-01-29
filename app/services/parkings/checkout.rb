# frozen_string_literal: true
module Parkings
  class Checkout < ApplicationService
    def initialize(parking)
      @parking = parking
    end

    def call
      @parking.checkout = Time.current
      @parking.left = true
      @parking.save

      @parking
    end
  end
end
