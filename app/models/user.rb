# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  belongs_to :store, optional: true

  validates :login, presence: true,
                    uniqueness: { case_sensitive: true },
                    length: { minimum: 8 }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :store_id, presence: true, if: :employee?

  enum role: { employee: 0, admin: 1 }
end
