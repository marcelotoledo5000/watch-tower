# frozen_string_literal: true

class StoresController < ApplicationController
  authorize_resource

  # GET /stores
  def index
    FilterStoresService.new(search_params).perform.then do |result|
      result.page(page_permitted).then do |stores|
        render json: stores, status: :ok
      end
    end
  end

  # GET /stores/:id
  def show
    Store.find(params[:id]).then do |store|
      json_response store
    end
  end

  # POST /stores
  def create
    Store.create!(store_params).then do |store|
      json_response store, :created
    end
  end

  # PUT /stores/:id
  def update
    Store.find(params[:id]).then do |store|
      store.update(store_params).then do |result|
        json_response result, :no_content
      end
    end
  end

  # DELETE /stores/:id
  def destroy
    Store.find(params[:id]).destroy.then do |store|
      json_response store, :no_content
    end
  end

  private

  # TODO: need to handle the format of the input data (cnpj)
  def store_params
    params.require(:store).permit(:cnpj, :name)
  end

  def search_params
    params.fetch(:search, {}).permit(:cnpj, :name)
  end
end
