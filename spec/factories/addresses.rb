FactoryBot.define do
  factory :address do
    suburb { "MyString" }
    country { "MyString" }
    street { "MyString" }
    postcode { "MyString" }
    belongs_to { "" }
  end
end
