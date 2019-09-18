# frozen_string_literal: true

class Larp < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy
  has_many :characters, dependent: :destroy

  validates :title, :description, :start_date, presence: true
  validates_associated :address
  accepts_nested_attributes_for :address

  def belongs_to_current_user?(user)
    return false if user.nil?

    user_id == user.id
  end

  def larp_created_within_a_week?
    ((7.days.ago)..(Time.now)).include?(created_at)
  end
end
