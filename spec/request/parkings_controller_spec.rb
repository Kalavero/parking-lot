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

  describe 'PUT /parking/:id/pay' do
    context 'when parking is not present' do
      before { put '/parking/inexistent_id/pay' }

      it 'returns HTTP status 404 not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a json error response' do
        expect(json_response)
          .to eq(errors: ["Couldn't find Parking with 'id'=inexistent_id"])
      end
    end

    context 'when everithing is fine' do
      let(:parking) { create(:parking, checkin: 10.minutes.ago) }

      before do
        travel_to Time.current
        put "/parking/#{parking.id}/pay"
      end

      it 'returns http status 200 ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the parking as json' do
        expect(json_response).to eq(data: {
          id: parking.id.to_s,
          type: 'parking',
          attributes: {
            paid: true,
            left: false,
            time: '10 minutes'
          }
        })
      end

      after { travel_back }
    end
  end

  describe 'PUT /parking/:id/out' do
    context 'when parking is not present' do
      before { put '/parking/inexistent_id/out' }

      it 'returns HTTP status 404 not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a json error response' do
        expect(json_response)
          .to eq(errors: ["Couldn't find Parking with 'id'=inexistent_id"])
      end
    end

    context 'when parking was not paid' do
      let(:parking) { create(:parking, checkin: 10.minutes.ago) }

      before do
        travel_to Time.current
        put "/parking/#{parking.id}/out"
      end

      it 'returns http status 422 unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a json error response' do
        expect(json_response).to eq(errors: ['parking not paid'])
      end

      after { travel_back }
    end

    context 'when everithing is fine' do
      let(:parking) do
        create(:parking,
               checkin: 10.minutes.ago,
               payment_time: Time.current,
               paid: true)
      end

      before do
        put "/parking/#{parking.id}/out"
      end

      it 'returns http status 200 ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the parking as json' do
        expect(json_response).to eq(data: {
          id: parking.id.to_s,
          type: 'parking',
          attributes: {
            paid: true,
            left: true,
            time: '10 minutes'
          }
        })
      end
    end
  end

  describe 'GET /parking/:plate' do
    context 'when plate cant be found' do
      before { get '/parking/inexistent_plate' }

      it 'returns http status 200 ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns an empty data array' do
        expect(json_response).to eq(data: [])
      end
    end

    context 'when plate exists' do
      let(:parkings) { create_list(:parking, 2, checkin: 20.minutes.ago) }

      before { get "/parking/#{parkings.first.plate}" }

      it 'returns http status 200 ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns an array with all parkings matching this plate' do
        expect(json_response).to eq(data: [
          {
            id: parkings.first.id.to_s,
            type: 'parking',
            attributes: {
              left: false,
              paid: false,
              time: '20 minutes'
            }
          },
          {
            id: parkings.last.id.to_s,
            type: 'parking',
            attributes: {
              left: false,
              paid: false,
              time: '20 minutes'
            }
          }
        ])
      end
    end
  end
end
