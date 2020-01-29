# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Parkings', type: :request do
  describe 'POST /parking' do
    context 'when plate is not present' do
      before { post '/parking' }

      it 'returns HTTP status 400 bad request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns a json error response' do
        expect(json_response)
          .to eq(errors: ['param is missing or the value is empty: plate'])
      end
    end

    context 'when plate has invalid format' do
      before { post '/parking', params: {plate: 'AAA-99XA'}}

      it 'returns HTTP status 422 unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when everithing is fine' do
      before { post '/parking', params: {plate: 'AAA-9999'} }

      it 'returns http status 201 created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the parking as json' do
        parking = Parking.last
        expect(json_response).to eq(data: {
          id: parking.id.to_s,
          type: 'parking',
          attributes: {
            paid: false,
            left: false,
            time: '0 minutes'
          }
        })
      end
    end
  end
end
