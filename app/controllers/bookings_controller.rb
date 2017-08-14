class BookingsController < ApplicationController

  def create
    @booking = current_user.bookings.new(booking_params)
    @ship = Ship.find(params[:ship_id])
    @booking.ship = @ship

    if @booking.save
      redirect_to booking_path(@booking)
    else
      render ship_path(@ship)
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_at, :end_at, :ship_id, :user_id)
  end
end
