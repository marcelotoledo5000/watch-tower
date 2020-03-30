# frozen_string_literal: true

class VisitorsController < ApplicationController
  # POST /visitors
  def create
    Visitor.create!(visitor_params).then do |visitor|
      json_response visitor, :created
    end
  end

  # GET /visitors/:id
  def show
    Visitor.find(params[:id]).then do |visitor|
      json_response visitor
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

  def visitor_params
    params.require(:visitor).permit(:cpf, :name, :profile_photo, :store_id)
  end
end
