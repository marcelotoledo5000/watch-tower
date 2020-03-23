# frozen_string_literal: true

class StoresController < ApplicationController
  # POST /stores
  def create
    Store.create!(store_params).then do |store|
      json_response store, :created
    end
  end

  # GET /stores/:id
  def show
    Store.find(params[:id]).then do |store|
      json_response store
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

  def store_params
    params.require(:store).permit(:cnpj, :name)
  end
end
