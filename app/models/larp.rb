# frozen_string_literal: true

class Larp < ApplicationRecord
  has_one :address, dependent: :destroy
  belongs_to :user
  has_many :characters

  validates :title, :description, :start_date, presence: true
  accepts_nested_attributes_for :address

  def belongs_to_current_user?(user)
    user_id == user.id
  end
end
