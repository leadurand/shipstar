class BookingsController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def create
    @ship = Ship.find(params[:ship_id])
    @user = current_user
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
    @ship = @booking.ship
    @booking_coordinates = { lat: @ship.latitude, lng: @ship.longitude }
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

  # def require_login
  #   if current_user # is NOT logged
  #     redirect_to "devise/sessions/new"

  #   else
  #     render :create
  #   end
  # end
end
