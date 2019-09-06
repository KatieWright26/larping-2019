# frozen_string_literal: true

class Larp < ApplicationRecord
  has_one :address
  belongs_to :user
  validates :title, :description, :start_date, presence: true
  accepts_nested_attributes_for :address
end
