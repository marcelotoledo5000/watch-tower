# frozen_string_literal: true

class Store < ApplicationRecord
  validates :cnpj, presence: true, length: { maximum: 14 }
  validates :cnpj, uniqueness: true, case_sensitive: false
  validates :name, presence: true
end
