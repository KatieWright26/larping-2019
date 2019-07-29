class Address < ApplicationRecord
    belongs_to :larp
    validates :country, :street, :postcode, presence: true
end
