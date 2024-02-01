require 'rails_helper'

RSpec.describe 'Api::V1::HealthChecks' do
  describe 'GET /api/v1/health_check' do
    context 'サーバが正常に動いているとき' do
      it 'ステータスコード200が返ってくること' do
        get '/api/v1/health_check'
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
