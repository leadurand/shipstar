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
    @ships = []
    @ships << @booking.ship
    @hash = Gmaps4rails.build_markers(@ships) do |ship, marker|
      marker.lat ship.latitude
      marker.lng ship.longitude
      marker.picture({
        "url" => view_context.image_path('rocket_pointer.png'),
        "width" => 64,
        "height" => 64
      })
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    redirect_to bookings_path
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.approved = true
    @booking.save
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_at, :end_at)
  end
end

# reminder : 3 status (Approved pending canceled)
# Authorize to add review => Only When booking is approved
# delete this review
