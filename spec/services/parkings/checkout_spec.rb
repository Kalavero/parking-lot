# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Parkings::Checkout do
  let(:parking) { build(:parking) }

  describe '.call' do
    subject { described_class.call(parking) }

    it 'sets the parking attributes correctly' do
      freeze_time do
        expect(subject)
          .to have_attributes(checkout: Time.current, left: true)
      end
    end

    it 'returns a parking' do
      expect(subject).to be_instance_of Parking
    end
  end
end
