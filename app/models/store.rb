# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :visitors, inverse_of: :store, dependent: :destroy
  has_many :appointments, inverse_of: :store, dependent: :destroy
  has_many :users, inverse_of: :store, dependent: :destroy

  validates :cnpj, presence: true, length: { maximum: 14 }
  validates :cnpj, uniqueness: { case_sensitive: false }
  validates :name, presence: true
end
