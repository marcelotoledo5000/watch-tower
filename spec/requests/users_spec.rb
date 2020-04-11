# frozen_string_literal: true

require 'rails_helper'

describe 'Users', type: :request do
  describe 'POST /signup' do
    let(:store) { create(:store) }
    let(:login) { Faker::Internet.username(specifier: 8) }
    let(:email) { Faker::Internet.email }
    let(:name) { Faker::Books::Dune.character }
    let(:password) { Faker::Internet.password }
    let(:role) { 'employee' }
    let(:store_id) { store.id }

    let(:valid_params) do
      {
        user: {
          login: login,
          email: email,
          name: name,
          password: password,
          role: role,
          store_id: store_id
        }
      }
    end

    context 'when user is created' do
      before { post users_path, params: valid_params }

      it { expect(response).to have_http_status :created }

      it 'returns a new user' do
        expect(json).not_to be_empty
        expect(json).to include(valid_params[:user].except(:password))
      end
    end

    context 'when user already exists' do
      let(:error_msg) { 'Validation failed: Email has already been taken' }

      before do
        create(:user, valid_params[:user])
        post users_path, params: valid_params
      end

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(json[:message]).to match(/#{error_msg}/) }
    end

    context 'when the request is invalid' do
      let(:invalid_params) { {} }
      let(:error_msg) { 'param is missing or the value is empty: user' }

      before { post users_path, params: invalid_params }

      it { expect(response).to have_http_status :bad_request }
      it { expect(json[:message]).to match(/#{error_msg}/) }
    end

    context 'when the password is less than the minimum required' do
      let(:password) { '1234567' }

      before { post users_path, params: valid_params }

      it 'returns status code 422' do
        expect(json).not_to be_empty
        expect(response).to have_http_status :unprocessable_entity
        expect(json[:message]).to match(/(minimum is 8 characters)/)
      end
    end
  end

  describe 'GET /users' do
    context 'when the user is unauthorized' do
      before do
        get users_path,
            headers: headers
      end

      xit 'returns status code 401' do
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'when returns users' do
      before do
        create_list(:user, 25)
        get users_path
      end

      it { expect(json).not_to be_empty }
      it { expect(json.size).to eq 20 }
      it { expect(User.count).to eq 25 }
      it { expect(response).to have_http_status :ok }
    end
  end

  describe 'PUT /users/:id' do
    context 'when the record exists' do
      let(:user) { create(:user) }
      let(:store) { create(:store) }
      let(:login) { Faker::Internet.username(specifier: 8) }
      let(:email) { Faker::Internet.email }
      let(:name) { Faker::Books::Dune.character }
      let(:password) { Faker::Internet.password }
      let(:role) { 'employee' }
      let(:store_id) { store.id }

      let(:valid_params) do
        {
          user: {
            login: login,
            email: email,
            name: name,
            password: password,
            role: role,
            store_id: store_id
          }
        }
      end

      before do
        put user_path(user.id), params: valid_params
      end

      it 'updates the user' do
        user.reload

        expect(user.attributes.symbolize_keys).
          to include(valid_params[:user].except(:password))
      end

      it 'returns status code 204' do
        expect(response.body).to be_empty
        expect(response).to have_http_status :no_content
      end
    end

    context 'when the record does not exist' do
      before do
        put user_path(100)
      end

      it { expect(response).to have_http_status :not_found }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User with 'id'=100/)
      end
    end
  end
end