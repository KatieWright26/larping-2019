# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def edit?
    return false if @user.nil?

    @user.id == @record.id
  end

  def update?
    return false if @user.nil?

    @user.id == @record.id
  end

  def initialize(user, record)
    @user = user
    @record = record
  end
end
