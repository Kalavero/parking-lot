# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Parkings::Checkout do
  let(:parking) { build(:parking, checkout: nil) }

  describe '.call' do
    subject { described_class.call(parking) }

    context 'when parking was paid' do
      before { parking.paid = true }

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

    context 'when parking was not paid' do
      it 'does not sets the attributes' do
        freeze_time do
          expect(parking)
            .to have_attributes(checkout: nil, left: false)
        end
      end

      it 'returns a false' do
        expect(subject).to be false
      end
    end
  end
end
