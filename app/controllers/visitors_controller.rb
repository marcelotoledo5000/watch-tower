# frozen_string_literal: true

class VisitorsController < ApplicationController
  authorize_resource

  # GET /visitors
  def index
    FilterVisitorsService.new(search_params).perform.then do |result|
      result.page(page_permitted).then do |visitors|
        render json: visitors, status: :ok, root: 'visitors'
      end
    end
  end

  # GET /visitors/:id
  def show
    Visitor.find(params[:id]).then do |visitor|
      json_response visitor
    end
  end

  # POST /visitors
  def create
    Visitor.create!(visitor_params).then do |visitor|
      json_response visitor, :created
    end
  end

  # PUT /visitors/:id
  def update
    Visitor.find(params[:id]).then do |visitor|
      visitor.update(visitor_params).then do |result|
        json_response result, :no_content
      end
    end
  end

  # DELETE /visitors/:id
  def destroy
    Visitor.find(params[:id]).destroy.then do |visitor|
      json_response visitor, :no_content
    end
  end

  private

  # TODO: need to handle the format of the input data (cpf)
  def visitor_params
    params.require(:visitor).permit(:cpf, :name, :profile_photo, :store_id)
  end

  def search_params
    params.fetch(:search, {}).permit(:cpf, :name)
  end
end
