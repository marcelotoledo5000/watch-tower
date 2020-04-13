# frozen_string_literal: true

class ReportsController < ApplicationController
  skip_before_action :authenticate_user!

  # GET /reports
  def index
    render json: StoreIndexService.new, serializer: StoreIndexSerializer
  end
end
