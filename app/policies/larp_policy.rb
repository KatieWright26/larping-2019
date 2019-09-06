# frozen_string_literal: true

class LarpPolicy < ApplicationPolicy
  def new?
    !@user.nil?
  end

  def create?
    !@user.nil?
  end

  def edit?
    @larp.user == @user
  end

  def update?
    @larp.user == @user
  end

  def destroy?
    @larp.user == @user
  end

  def initialize(user, larp)
    @user = user
    @larp = larp
  end
end
