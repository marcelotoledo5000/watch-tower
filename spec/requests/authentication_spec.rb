# frozen_string_literal: true

require 'rails_helper'

describe 'Authentication' do
  let(:devise_key) { ENV.fetch('DEVISE_JWT_SECRET_KEY', nil) }
  let(:user) { create(:user) }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  describe 'POST /login' do
    context 'when params are correct' do
      before do
        post user_session_path, params: params
      end

      it { expect(response).to have_http_status :ok }

      it 'returns JTW token in authorization header' do
        expect(response.headers['Authorization']).to be_present
      end

      it 'returns valid JWT token' do
        token_from_request = response.headers['Authorization'].split.last
        decoded_token = JWT.decode(token_from_request, devise_key, true)

        expect(decoded_token.first['sub']).to be_present
      end
    end

    context 'when login params are incorrect' do
      before { post user_session_path }

      it { expect(response).to have_http_status :unauthorized }
    end
  end

  describe 'DELETE /logout' do
    it do
      # create new session and get token
      post user_session_path, params: params
      token_from_request = response.headers['Authorization'].split.last

      # delete this user session
      delete destroy_user_session_path,
             headers: { 'Authorization' => "Bearer #{token_from_request}" }

      # decode token and get jti
      decoded_token = JWT.decode(token_from_request, devise_key, true)
      jti_from_token = decoded_token.first['jti']

      expect(response).to have_http_status :no_content
      expect(JwtBlacklist.count).to eq 1
      expect(JwtBlacklist.last.jti).to eq jti_from_token
    end
  end
end
