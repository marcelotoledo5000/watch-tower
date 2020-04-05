# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    login { Faker::Internet.username(specifier: 8) }
    email { Faker::Internet.email }
    name { Faker::Books::Dune.character }
    password { Faker::Internet.password(min_length: 8) }
    role { 'admin' }
    store { nil }
  end
end
