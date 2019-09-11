# frozen_string_literal: true

class Character < ApplicationRecord
  belongs_to :larp
  # belongs_to :user
  validates :name, :description, presence: true
end
