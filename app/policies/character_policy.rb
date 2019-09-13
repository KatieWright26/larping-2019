# frozen_string_literal: true

class CharacterPolicy < ApplicationPolicy
  def new?
    user_owns_larp?
  end

  def create?
    user_owns_larp?
  end

  def edit?
    user_owns_larp?
  end

  def update?
    user_owns_larp?
  end

  def destroy?
    user_owns_larp?
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  private

  def user_owns_larp?
    @user.larps.include?(@record.larp)
  end
end