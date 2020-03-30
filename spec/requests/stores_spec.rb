# frozen_string_literal: true

require 'rails_helper'

describe 'Stores', type: :request do
  describe 'POST /stores' do
    let(:valid_params) do
      {
        store: {
          cnpj: 10_000_111_000_100,
          name: 'Maximus Store'
        }
      }
    end

    context 'when the request is valid' do
      before do
        post stores_path,
             params: valid_params
      end

      it 'creates a store' do
        expect(response).to have_http_status :created
        expect(json).not_to be_empty
        expect(json[:cnpj]).to eq '10000111000100'
        expect(json[:name]).to eq 'Maximus Store'
      end
    end

    context 'when is bad request' do
      it 'returns status code 400' do
        expect { post stores_path }.
          to raise_error ActionController::ParameterMissing
      end
    end

    context 'when the request is invalid' do
      before do
        post stores_path,
             params: { store: { cnpj: '' } }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status :unprocessable_entity
        expect(json).not_to be_empty
      end
    end

    xcontext 'when the user is unauthorized' do
      before do
        post stores_path,
             params: valid_params
      end

      it { expect(response).to have_http_status :unauthorized }
    end
  end

  describe 'GET /stores' do
    context 'when call the index of stores' do
      let(:stores) { create_list(:store, 11) }

      before do
        stores
        get stores_path
      end

      it 'returns the stores' do
        expect(json).not_to be_empty
        expect(json.size).to eq 11
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'with search by cnpj' do
      let(:store) { create(:store, cnpj: 11_222_333_000_100) }
      let(:stores) { create_list(:store, 10) }
      let(:params) do
        {
          search: {
            cnpj: 11_222_333_000_100 # or '11_222_333_000_100'
          }
        }
      end

      before do
        store
        stores
        get stores_path, params: params
      end

      it 'returns the store' do
        expect(json).not_to be_empty
        expect(json.first[:stores][:id]).to eq store.id
        expect(json.first[:stores][:cnpj]).to eq store.cnpj
        expect(json.first[:stores][:name]).to eq store.name
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'with search by name' do
      let(:store) { create(:store, name: 'The Incredible Store') }
      let(:stores) { create_list(:store, 10) }
      let(:params) do
        {
          search: {
            name: 'incredible'
          }
        }
      end

      before do
        store
        stores
        get stores_path, params: params
      end

      it 'returns the store' do
        expect(json).not_to be_empty
        expect(json.first[:stores][:id]).to eq store.id
        expect(json.first[:stores][:cnpj]).to eq store.cnpj
        expect(json.first[:stores][:name]).to eq store.name
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when the record does not exist' do
      let(:store) { create(:store, name: 'The Incredible Store') }
      let(:params) do
        {
          search: {
            name: 'AbrahCadabrah'
          }
        }
      end

      before do
        store
        get stores_path, params: params
      end

      it { expect(response).to have_http_status :ok }
      it { expect(json).to be_empty }
    end
  end

  describe 'GET /stores/:id' do
    context 'when the record exists' do
      let(:store) { create(:store) }

      before do
        get store_path(store.id)
      end

      it 'returns the store' do
        expect(json).not_to be_empty
        expect(json[:cnpj]).to eq store.cnpj
        expect(json[:name]).to eq store.name
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when the record does not exist' do
      before do
        get store_path(100)
      end

      it { expect(response).to have_http_status :not_found }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Store with 'id'=100/)
      end
    end
  end

  describe 'PUT /stores/:id' do
    context 'when the record exists' do
      let(:store) { create(:store) }

      let(:valid_params) do
        {
          store: {
            cnpj: 10_111_222_000_100,
            name: 'The Best Store'
          }
        }
      end

      before do
        put store_path(store.id),
            params: valid_params
      end

      it 'updates the store' do
        store.reload

        expect(store.cnpj).to eq '10111222000100'
        expect(store.name).to eq 'The Best Store'
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

  describe 'DELETE /stores/:id' do
    context 'when the record exists' do
      let(:store) { create(:store) }
      let(:id) { store.id }
      let(:message) { "Couldn't find Store with 'id'=#{id}" }

      before do
        delete store_path(store.id)
      end

      it 'deletes the store' do
        expect { store.reload }.
          to raise_error(ActiveRecord::RecordNotFound, message)
      end

      it 'returns status code 204' do
        expect(response.body).to be_empty
        expect(response).to have_http_status :no_content
      end
    end

    context 'when the record does not exist' do
      before do
        delete store_path(100)
      end

      it { expect(response).to have_http_status :not_found }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Store with 'id'=100/)
      end
    end
  end
end
