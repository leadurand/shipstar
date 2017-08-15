class PagesController < ApplicationController
  def home
  	@ship = Ship.new
  	@ships = Ship.all
  end
end
