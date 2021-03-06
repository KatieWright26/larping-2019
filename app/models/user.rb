# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :larps, inverse_of: :user
  validates :email, :name, presence: true

  class << self
    def create_with_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth['info']['email']
        user.password = Devise.friendly_token[0, 20]
        user.name = auth['info']['name']
      end
    end
  end
end
