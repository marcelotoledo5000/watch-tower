# frozen_string_literal: true

FactoryBot.define do
  factory :visitor do
    cpf { Faker::IDNumber.unique.brazilian_citizen_number }
    name { Faker::Books::Dune.character }
    profile_photo { Faker::File.file_name(dir: 'path/to', ext: 'jpg') }
    store
  end
end
