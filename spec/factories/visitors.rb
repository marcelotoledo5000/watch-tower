# frozen_string_literal: true

FactoryBot.define do
  factory :visitor do
    cpf { Faker::IDNumber.brazilian_citizen_number }
    name { Faker::Books::Dune.character }
    store
  end
end
