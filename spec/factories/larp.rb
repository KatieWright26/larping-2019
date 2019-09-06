# frozen_string_literal: true

FactoryBot.define do
  factory :larp do
    title { 'MyString' }
    description { 'MyString' }
    start_date { Time.now + 10 }
  end
end
