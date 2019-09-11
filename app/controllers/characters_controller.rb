# frozen_string_literal: true

class CharactersController < ApplicationController
  def new
    @character = Character.new
    @larp = Larp.find(params[:larp_id])
    @character.larp_id = @larp.id
    authorize @character
  end

  def create
    @character = Character.new(character_params)
    @larp = @character.larp
    if @character.save!
      message = "Success! #{@character.name} has been added to #{@larp}."
      redirect_to larp_path(@larp), notice: message
    else

      render :new
    end
  end

  def show
    @character = Character.find(params[:id])
  end

  def edit
    @character = Character.find(params[:id])
  end

  def destroy; end

  def update
    @character = Character.find(params[:id])

    if @character.update(character_params)
    end
  end

  def assign; end

  def unassign; end

  private

  def character_params
    params.require(:character).permit(:name, :description, :race, :occupation, :larp_id)
  end
end
