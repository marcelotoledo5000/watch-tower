# frozen_string_literal: true

require 'rails_helper'

describe 'Appointments', type: :request do
  describe 'POST /appointments' do
    let(:visitor) { create(:visitor) }
    let(:store) { create(:store) }
    let(:valid_params) do
      {
        appointment: {
          visitor_id: visitor.id,
          store_id: store.id,
          kind: 'check_in',
          event_time: Time.current
        }
      }
    end

    context 'when the request is valid' do
      let(:formatted_time) do
        formatted_date(valid_params[:appointment][:event_time])
      end

      before do
        post appointments_path,
             params: valid_params
      end

      it 'creates a appointment' do
        expect(response).to have_http_status :created
        expect(json).not_to be_empty
        expect(json[:visitor]).to eq visitor.name
        expect(json[:store]).to eq store.name
        expect(json[:kind]).to eq valid_params[:appointment][:kind]
        expect(json[:event_time]).to eq formatted_time
      end
    end

    context 'when is bad request' do
      let(:error_msg) { 'param is missing or the value is empty: appointment' }

      before { post appointments_path, params: {} }

      it { expect(response).to have_http_status :bad_request }
      it { expect(json[:message]).to match(/#{error_msg}/) }
    end

    context 'when the request is invalid' do
      before do
        post appointments_path,
             params: { appointment: { field: '' } }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status :unprocessable_entity
        expect(json).not_to be_empty
      end
    end

    xcontext 'when the user is unauthorized' do
      before do
        post appointments_path,
             params: valid_params
      end

      it { expect(response).to have_http_status :unauthorized }
    end
  end

  describe 'GET /appointments' do
    context 'when call the index of appointments' do
      let(:appointments) { create_list(:appointment, 21) }

      before do
        appointments
        get appointments_path
      end

      it 'returns the appointments' do
        expect(json).not_to be_empty
        expect(json.size).to eq 20
      end

      it { expect(response).to have_http_status :ok }
    end

    xcontext 'when the user is unauthorized' do
      before do
        get appointments_path
      end

      it { expect(response).to have_http_status :unauthorized }
    end
  end
end
