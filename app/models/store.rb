# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :visitors, inverse_of: :store, dependent: :destroy

  validates :cnpj, presence: true, length: { maximum: 14 }
  validates :cnpj, uniqueness: true, case_sensitive: false
  validates :name, presence: true
end
