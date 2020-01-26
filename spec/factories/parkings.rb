FactoryBot.define do
  factory :parking do
    plate { "MyString" }
    checkin { "2020-01-26 13:21:08" }
    checkout { "2020-01-26 13:21:08" }
    payment_time { "2020-01-26 13:21:08" }
    paid { false }
    paid_value { 1.5 }
    left { false }
  end
end
