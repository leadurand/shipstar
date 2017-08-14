class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_at, :end_at, :user_id, :ship_id)
  end
end
