class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end
  
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    redirect_to bookings_path
  end

end
