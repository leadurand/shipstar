class BookingsController < ApplicationController

  def create
    @ship = Ship.find(params[:ship_id])
    @user = User.find(params[:ship_id])
    @booking = @user.bookings.new(booking_params)
    @booking.ship = @ship

    if @booking.save
      redirect_to booking_path(@booking)
    else
      render "ships/show"
    end
  end

  def index
    @bookings = current_user.bookings
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
    params.require(:booking).permit(:start_at, :end_at)
  end
end
