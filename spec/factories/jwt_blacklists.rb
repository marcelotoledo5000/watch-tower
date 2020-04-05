# frozen_string_literal: true

FactoryBot.define do
  factory :jwt_blacklist do
    jti { Faker::Internet.uuid }
    exp { Faker::Date.forward(days: 2) }
  end
end
