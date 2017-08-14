class PagesController < ApplicationController
  def home
  	@ship = Ship.new
  end
end
