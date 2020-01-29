# frozen_string_literal: true
module Parkings
  class Pay < ApplicationService
    def initialize(parking)
      @parking = parking
    end

    def call
      @parking.payment_time = Time.current
      @parking.paid = true
      @parking.save

      @parking
    end
  end
end
