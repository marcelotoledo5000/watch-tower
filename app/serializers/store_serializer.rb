# frozen_string_literal: true

class StoreSerializer < ActiveModel::Serializer
  attributes :id, :cnpj, :name, :total_visitors

  has_many :visitors, serializer: VisitorSerializer

  def total_visitors
    object.visitors.length
  end
end
