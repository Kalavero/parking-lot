# frozen_string_literal: true
class Parking < ApplicationRecord
  validates :plate, format: {with: /[A-Z]{3}-\d{4}/}, presence: true
end
