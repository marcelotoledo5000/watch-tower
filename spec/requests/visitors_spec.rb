# frozen_string_literal: true

require 'rails_helper'

describe 'Visitors', type: :request do
  describe 'POST /visitors' do
    let(:store) { create(:store) }
    let(:valid_params) do
      {
        visitor: {
          cpf: 111_222_333_45,
          name: 'Thorfast Karsson',
          profile_photo: 'Photo171',
          store_id: store.id
        }
      }
    end

    context 'when the request is valid' do
      before do
        post visitors_path,
             params: valid_params
      end

      it 'creates a store' do
        expect(response).to have_http_status :created
        expect(json).not_to be_empty
        expect(json[:cpf]).to eq '11122233345'
        expect(json[:name]).to eq 'Thorfast Karsson'
        expect(json[:profile_photo]).to eq 'Photo171'
      end
    end

    context 'when is bad request' do
      it 'returns status code 400' do
        expect { post visitors_path }.
          to raise_error ActionController::ParameterMissing
      end
    end

    context 'when the request is invalid' do
      before do
        post visitors_path,
             params: { visitor: { cnpj: '' } }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status :unprocessable_entity
        expect(json).not_to be_empty
      end
    end

    xcontext 'when the user is unauthorized' do
      before do
        post visitors_path,
             params: valid_params
      end

      it { expect(response).to have_http_status :unauthorized }
    end
  end

  describe 'GET /visitors/:id' do
    context 'when the record exists' do
      let(:store) { create(:store) }
      let(:visitor) { create(:visitor, store: store) }

      before do
        get visitor_path(visitor.id)
      end

      it 'returns the visitor' do
        expect(json).not_to be_empty
        expect(json[:cpf]).to eq visitor.cpf
        expect(json[:name]).to eq visitor.name
        expect(json[:profile_photo]).to eq visitor.profile_photo
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when the record does not exist' do
      before do
        get visitor_path(100)
      end

      it { expect(response).to have_http_status :not_found }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Visitor with 'id'=100/)
      end
    end
  end

  describe 'PUT /visitors/:id' do
    context 'when the record exists' do
      let(:store) { create(:store) }
      let(:visitor) { create(:visitor, store: store) }

      let(:valid_params) do
        {
          visitor: {
            cpf: 111_222_333_45,
            name: 'Thorfast Karsson',
            profile_photo: 'Photo1'
          }
        }
      end

      before do
        put visitor_path(visitor.id),
            params: valid_params
      end

      it 'updates the visitor' do
        visitor.reload

        expect(visitor.cpf).to eq '11122233345'
        expect(visitor.name).to eq 'Thorfast Karsson'
        expect(visitor.profile_photo).to eq 'Photo1'
      end

      it 'returns status code 204' do
        expect(response.body).to be_empty
        expect(response).to have_http_status :no_content
      end
    end

    context 'when the record does not exist' do
      before do
        put store_path(100)
      end

      it { expect(response).to have_http_status :not_found }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Store with 'id'=100/)
      end
    end
  end

  describe 'DELETE /visitors/:id' do
    context 'when the record exists' do
      let(:store) { create(:store) }
      let(:visitor) { create(:visitor, store: store) }
      let(:id) { visitor.id }
      let(:message) { "Couldn't find Visitor with 'id'=#{id}" }

      before do
        delete visitor_path(visitor.id)
      end

      it 'deletes the visitor' do
        expect { visitor.reload }.
          to raise_error(ActiveRecord::RecordNotFound, message)
      end

      it 'returns status code 204' do
        expect(response.body).to be_empty
        expect(response).to have_http_status :no_content
      end
    end

    context 'when the record does not exist' do
      let(:id) { 100 }
      let(:message) { "Couldn't find Visitor with 'id'=#{id}" }

      before do
        delete visitor_path(id)
      end

      it { expect(response).to have_http_status :not_found }

      it 'returns a not found message' do
        expect(response.body).to match(/#{message}/)
      end
    end
  end
end
