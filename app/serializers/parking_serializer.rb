# frozen_string_literal: true
class ParkingSerializer
  include FastJsonapi::ObjectSerializer
  set_type :parking
  attributes :paid, :left

  attribute :time do |object|
    if object.paid?
      ((object.payment_time - object.checkin) / 1.minutes).to_i
    else
      ((Time.current - object.checkin) / 1.minutes).to_i
    end.to_s + ' minutes'
  end
end
