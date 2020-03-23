# frozen_string_literal: true

class StoresController < ApplicationController
  # POST /stores
  def create
    Store.create!(store_params).then do |store|
      json_response store, :created
    end
  end

  private

  def store_params
    params.require(:store).permit(:cnpj, :name)
  end
end