# frozen_string_literal: true

class LarpsController < ApplicationController
  def index
    @larps = Larp.all
    authorize @larps
  end

  def new
    @larp = Larp.new
    @address = Address.new
    authorize @larp
    if current_user.nil?
      redirect_to root_path
    else
      @user = User.find(current_user.id)
      render :new
    end
  end

  def create
    @larp = Larp.new(permitted_params)
    authorize @larp

    if @larp.save!
      flash[:notice] = 'Larp created'
      redirect_to root_path
    else
      flash[:alert] = 'Larp not created'
      render :new
    end
  end

  def show
    @larp = Larp.find(params[:id])
    authorize @larp
  end

  def edit
    @larp = Larp.find(params[:id])
    @address = @larp.address
    authorize @larp
    if current_user == @larp.user
      render :edit
    else
      message = 'You are not authorized to perform that action'
      redirect_to root_path, alert: message
    end
  end

  def update
    @larp = Larp.find(params[:id])
    authorize @larp
    if @larp.update(permitted_params) && current_user == @larp.user
      message = 'LARP successfully updated'
      redirect_to larp_path(@larp), notice: message
    else
      render :edit
    end
  end

  def destroy
    @larp = Larp.find(params[:id])
    authorize @larp
    @larp.destroy!
  end

  private

  def permitted_params
    params.require(:larp).permit(:title,
                                 :description, :start_date, :user_id,
                                 address_attributes: %i[
                                   suburb
                                   country
                                   street
                                   postcode
                                 ])
  end
end
