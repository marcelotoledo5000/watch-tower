# frozen_string_literal: true

class Visitor < ApplicationRecord
  belongs_to :store, inverse_of: :visitors
  has_many :appointments, inverse_of: :visitor, dependent: :destroy

  validates :cpf, presence: true, length: { maximum: 11 }
  validates :cpf, uniqueness: true, case_sensitive: false
  validates :name, presence: true
  validates :profile_photo, presence: true
end
