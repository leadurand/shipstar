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

  def index
    # => PENDING LOGIN FEATURE
    # @bookings = current_user.bookings
    @bookings = Booking.all
  end

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
    params.require(:booking).permit(:start_at, :end_at, :ship_id, :user_id)
  end
end
