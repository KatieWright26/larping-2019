class Larp < ApplicationRecord
    has_one :address
    belongs_to :user
    validates :title, :description, :start_date, presence: true
end
