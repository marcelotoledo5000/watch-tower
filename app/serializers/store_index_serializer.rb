# frozen_string_literal: true

class StoreIndexSerializer < ActiveModel::Serializer
  attributes :total_stores

  has_many :stores, serializer: StoreSerializer

  def total_stores
    object.stores.length
  end
end
