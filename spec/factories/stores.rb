# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    cnpj { Faker::Company.brazilian_company_number }
    name { Faker::Company.name }
  end
end
