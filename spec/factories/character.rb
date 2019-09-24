# frozen_string_literal: true

FactoryBot.define do
  factory :character do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    race { Faker::Creature::Animal.name }
    occupation { Faker::Job.title }
    larp
  end
end
