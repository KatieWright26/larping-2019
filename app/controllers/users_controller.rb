# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @larps = @user.larps
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
    render :edit
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(permitted_params)
      message = "Success! #{@user.name} has been updated."
      redirect_to user_path(@user.id), notice: message
    else
      render :edit
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:name)
  end
end
