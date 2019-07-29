# frozen_string_literal: true

class LarpsController < ApplicationController
  def index
    @larps = Larp.all
  end

  def new
    @larp = Larp.new
    @user = User.find(current_user.id)
  end

  def create
    @larp = Larp.new(permitted_params)
    @user = User.find(params[:user_id])

    if @larp.save
      flash[:notice] = 'Larp created'
      redirect_to root_path
    else
      flash[:alert] = 'Larp not created'
      render :new
    end
  end

  def show; end

  private

  def permitted_params
    params.require(:larp).permit(:title,
                                 :description, :start_date, :user_id,
                                 address_attributes: %i[suburb country street postcode])
  end
end
