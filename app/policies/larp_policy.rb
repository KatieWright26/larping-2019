# frozen_string_literal: true

class LarpPolicy < ApplicationPolicy
  def new?
    !@user.nil?
  end

  def create?
    !@user.nil?
  end

  def edit?
    larp_belongs_to_current_user?
  end

  def update?
    larp_belongs_to_current_user?
  end

  def destroy?
    larp_belongs_to_current_user?
  end

  def initialize(user, larp)
    @user = user
    @larp = larp
  end

  def larp_belongs_to_current_user?
    @larp.user == @user
  end
end
