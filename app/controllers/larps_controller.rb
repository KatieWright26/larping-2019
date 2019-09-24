# frozen_string_literal: true

class LarpsController < ApplicationController
  def index
    @larps = Larp.all
    authorize @larps
  end

  def new
    @larp = Larp.new(user_id: params[:user_id])
    authorize @larp
    @address = Address.new
    render :new
  end

  def create
    @larp = Larp.new(permitted_params)
    authorize @larp
    if @larp.save!
      flash[:notice] = 'Success! You LARP has been created!'
      redirect_to root_path
    else
      flash[:alert] = 'Oops! There was an error creating your LARP.'
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
    render :edit
  end

  def update
    @larp = Larp.find(params[:id])
    authorize @larp
    if @larp.update(permitted_params)
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
    redirect_to larps_path, message: 'Your LARP has been deleted'
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
