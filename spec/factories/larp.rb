# frozen_string_literal: true

FactoryBot.define do
  factory :larp do
    title { Faker::Hipster.word }
    description { Faker::Hipster.paragraph }
    start_date { Time.now + 10 }
    user
    after(:build) do |larp|
      create(:address, larp: larp)
    end
  end
end
