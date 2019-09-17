# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @larps = Larp.all
  end
end
