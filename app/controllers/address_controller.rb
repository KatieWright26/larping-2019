# frozen_string_literal: true

class AddressesController < ApplicationController
  private

  def permitted_params
    params.require(:address).permit(:suburb, :country, :street, :postcode)
  end
end
