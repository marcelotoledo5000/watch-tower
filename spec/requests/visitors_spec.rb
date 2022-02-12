# frozen_string_literal: true

require 'rails_helper'

describe 'Visitors', type: :request do
  let(:user) { create(:user) }
  let(:headers) { request_headers_jwt(user) }

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
      before { post visitors_path, params: valid_params, headers: headers }

      it 'creates a store' do
        expect(response).to have_http_status :created
        expect(json).not_to be_empty
        expect(json[:cpf]).to eq '11122233345'
        expect(json[:name]).to eq 'Thorfast Karsson'
        expect(json[:profile_photo]).to eq 'Photo171'
      end
    end

    context 'when is bad request' do
      let(:error_msg) { 'param is missing or the value is empty: visitor' }

      before { post visitors_path, params: {}, headers: headers }

      it { expect(response).to have_http_status :bad_request }
      it { expect(json[:message]).to match(/#{error_msg}/) }
    end

    context 'when the request is invalid' do
      before do
        post visitors_path,
             params: { visitor: { cnpj: '' } },
             headers: headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status :unprocessable_entity
        expect(json).not_to be_empty
      end
    end

    context 'when the user is unauthorized' do
      let(:message) { 'You need to sign in or sign up before continuing.' }

      before { post visitors_path, headers: {} }

      it { expect(response).to have_http_status :unauthorized }
      it { expect(response.body).to eq message }
    end

    context 'when the user is an employee' do
      let(:user_store) { create(:store) }
      let(:employee) { create(:user, role: 'employee', store: user_store) }
      let(:headers) { request_headers_jwt(employee) }
      let(:message) { 'You are not authorized to access this page.' }

      before { post visitors_path, headers: headers }

      it { expect(response).to have_http_status :unauthorized }
      it { expect(json[:message]).to eq message }
    end
  end

  describe 'GET /visitors' do
    context 'when call the index of visitors' do
      let(:visitors) { create_list(:visitor, 11) }

      before do
        visitors
        get visitors_path, headers: headers
      end

      it 'returns the store' do
        expect(json).not_to be_empty
        expect(json.size).to eq 11
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'with search by cpf' do
      let(:visitor) { create(:visitor, cpf: 111_222_333_45) }
      let(:visitors) { create_list(:visitor, 10) }
      let(:params) do
        {
          search: {
            cpf: 111_222_333_45 # or '111_222_333_45'
          }
        }
      end

      before do
        visitor
        visitors
        get visitors_path, params: params, headers: headers
      end

      it 'returns the visitor' do
        expect(json).not_to be_empty
        expect(json.first[:id]).to eq visitor.id
        expect(json.first[:cpf]).to eq visitor.cpf
        expect(json.first[:name]).to eq visitor.name
        expect(json.first[:profile_photo]).to eq visitor.profile_photo
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'with search by name' do
      let(:visitor) { create(:visitor, name: 'Thorfast Karsson') }
      let(:visitors) { create_list(:visitor, 10) }
      let(:params) do
        {
          search: {
            name: 'kars'
          }
        }
      end

      before do
        visitor
        visitors
        get visitors_path, params: params, headers: headers
      end

      it 'returns the visitor' do
        expect(json).not_to be_empty
        expect(json.first[:id]).to eq visitor.id
        expect(json.first[:cpf]).to eq visitor.cpf
        expect(json.first[:name]).to eq visitor.name
        expect(json.first[:profile_photo]).to eq visitor.profile_photo
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when the record does not exist' do
      let(:visitor) { create(:visitor, name: 'Thorfast Karsson') }
      let(:params) do
        {
          search: {
            name: 'AbrahCadabrah'
          }
        }
      end

      before do
        visitor
        get visitors_path, params: params, headers: headers
      end

      it { expect(response).to have_http_status :ok }
      it { expect(json).to be_empty }
    end

    context 'when is unauthorized' do
      let(:message) { 'You need to sign in or sign up before continuing.' }

      before { get visitors_path, headers: {} }

      it { expect(response).to have_http_status :unauthorized }
      it { expect(response.body).to eq message }
    end
  end

  describe 'GET /visitors/:id' do
    context 'when the record exists' do
      let(:store) { create(:store) }
      let(:visitor) { create(:visitor, store: store) }

      before { get visitor_path(visitor.id), headers: headers }

      it 'returns the visitor' do
        expect(json).not_to be_empty
        expect(json[:cpf]).to eq visitor.cpf
        expect(json[:name]).to eq visitor.name
        expect(json[:profile_photo]).to eq visitor.profile_photo
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when the record does not exist' do
      before { get visitor_path(100), headers: headers }

      it { expect(response).to have_http_status :not_found }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Visitor with 'id'=100/)
      end
    end

    context 'when the user is unauthorized' do
      let(:message) { 'You need to sign in or sign up before continuing.' }

      before { get visitor_path(100), headers: {} }

      it { expect(response).to have_http_status :unauthorized }
      it { expect(response.body).to eq message }
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
            params: valid_params,
            headers: headers
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
      before { put visitor_path(100), headers: headers }

      it { expect(response).to have_http_status :not_found }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Visitor with 'id'=100/)
      end
    end

    context 'when the user is unauthorized' do
      let(:message) { 'You need to sign in or sign up before continuing.' }

      before { put visitor_path(100), headers: {} }

      it { expect(response).to have_http_status :unauthorized }
      it { expect(response.body).to eq message }
    end
  end

  describe 'DELETE /visitors/:id' do
    context 'when the record exists' do
      let(:store) { create(:store) }
      let(:visitor) { create(:visitor, store: store) }
      let(:id) { visitor.id }
      let(:message) { "Couldn't find Visitor with 'id'=#{id}" }

      before { delete visitor_path(visitor.id), headers: headers }

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

      before { delete visitor_path(id), headers: headers }

      it { expect(response).to have_http_status :not_found }

      it 'returns a not found message' do
        expect(response.body).to match(/#{message}/)
      end
    end

    context 'when the user is unauthorized' do
      let(:message) { 'You need to sign in or sign up before continuing.' }

      before { delete visitor_path(100), headers: {} }

      it { expect(response).to have_http_status :unauthorized }
      it { expect(response.body).to eq message }
    end
  end
end
