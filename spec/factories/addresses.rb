# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    suburb { 'MyString' }
    country { 'MyString' }
    street { 'MyString' }
    postcode { 'MyString' }
    belongs_to { '' }
  end
end
