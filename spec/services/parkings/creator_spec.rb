# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Parkings::Creator do
  describe '.call' do
    context 'when plate is valid' do
      subject { described_class.call('AAA-9999') }

      it 'creates a parking' do
        expect{subject}.to change(Parking, :count).by(1)
      end

      it 'sets the parking attributes correctly' do
        freeze_time do
          expect(subject)
            .to have_attributes(plate: 'AAA-9999', checkin: Time.current)
        end
      end

      it 'returns a parking' do
        expect(subject).to be_instance_of Parking
      end
    end

    context 'when plate is invalid' do
      subject { described_class.call('1X2-ABCD') }

      it 'returns false' do
        expect(subject).to be false
      end

      it 'does not creates a parking' do
        expect{subject}.not_to change(Parking, :count)
      end
    end
  end
end
