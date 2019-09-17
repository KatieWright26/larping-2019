# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :larps, inverse_of: :user
  validates :email, :password, :name, presence: true
  validates :password, length: { minimum: 6 }

  def self.create_with_omniauth(auth)
    binding.pry
    user = find_or_create_by(uid: auth['uid'], provider: auth['provider'])
    user.email = "#{auth['uid']}@#{auth['provider']}.com"
    user.password = auth['uid']
    user.name = auth['info']['name']

    return user if User.exists?(user)

    user.save!
    user
  end
end
