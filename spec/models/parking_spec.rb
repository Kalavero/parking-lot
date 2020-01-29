# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Parking do
  describe '.validations' do
    context 'plate' do
      subject { described_class.new }

      before { subject.save }

      it 'validates presence' do
        expect(subject.errors.full_messages).to include "Plate can't be blank"
      end

      it 'validates format' do
        expect(subject.errors.full_messages).to include "Plate is invalid"

        subject.plate = 'AAA-0000'
        subject.save

        expect(subject).to be_valid
      end
    end
  end
end
