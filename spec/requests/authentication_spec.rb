# frozen_string_literal: true

require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /login', type: :request do
    let(:user) { create(:user) }
    let(:params) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    context 'when params are correct' do
      let(:devise_key) { ENV['DEVISE_JWT_SECRET_KEY'] }

      before do
        post user_session_path, params: params
      end

      it { expect(response).to have_http_status :ok }

      it 'returns JTW token in authorization header' do
        expect(response.headers['Authorization']).to be_present
      end

      it 'returns valid JWT token' do
        token_from_request = response.headers['Authorization'].split(' ').last
        decoded_token = JWT.decode(token_from_request, devise_key, true)

        expect(decoded_token.first['sub']).to be_present
      end
    end

    context 'when login params are incorrect' do
      before { post user_session_path }

      it { expect(response).to have_http_status :unauthorized }
    end
  end

  describe 'DELETE /logout', type: :request do
    before { delete destroy_user_session_path }

    it { expect(response).to have_http_status :no_content }
  end
end
