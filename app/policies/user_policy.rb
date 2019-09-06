# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def edit?
    @user == current_user
  end
end
