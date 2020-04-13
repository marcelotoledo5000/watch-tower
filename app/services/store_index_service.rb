# frozen_string_literal: true

class StoreIndexService
  include ActiveModel::Serialization
  extend ActiveModel::Naming

  attr_accessor :stores

  def self.perform!
    new
  end

  def initialize
    @stores = Store.all
  end
end
