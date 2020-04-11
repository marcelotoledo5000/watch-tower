# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    visitor
    store
    kind { 'check_in' }
    event_time { Time.current }
  end
end
