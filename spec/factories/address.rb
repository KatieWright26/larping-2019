# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    suburb { Faker::Address.city }
    country { Faker::Address.country }
    street { Faker::Address.street_address }
    postcode { Faker::Address.postcode }
  end
end
