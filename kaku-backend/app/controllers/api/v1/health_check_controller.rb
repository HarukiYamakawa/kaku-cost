class Api::V1::HealthCheckController < ApplicationController
  def index
    render json: {
      message: 'helth_check OK'
    }, status: :ok
  end
end
