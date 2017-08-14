class ShipsController < ApplicationController

  def show
    @ship = Ship.find(params[:id])
    @booking = Booking.new
  end
end
