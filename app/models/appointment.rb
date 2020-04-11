# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :visitor, inverse_of: :appointments
  belongs_to :store, inverse_of: :appointments

  validates :event_time, presence: true

  enum kind: { check_in: 0, check_out: 1 }
end
