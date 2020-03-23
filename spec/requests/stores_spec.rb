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
        expect{ post stores_path }.
          to raise_error ActionController::ParameterMissing
      end
    end

    context 'when the request is invalid' do
      before do
        post stores_path,
             params: { store: { cnpj: ''} }
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
  end
end
