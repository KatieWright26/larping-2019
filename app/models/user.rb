# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :larps, inverse_of: :user
  validates :email, :password, :name, presence: true
  validates :password, length: { minimum: 6 }
end
