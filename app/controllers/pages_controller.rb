class PagesController < ApplicationController
  def home
  	@users = User.all
    @bookings = Booking.all
    @ship = Ship.new
  	@ships = Ship.all.last(3)
    @ships_all = Ship.all
    @hash = Gmaps4rails.build_markers(@ships_all) do |ship, marker|
         marker.lat ship.latitude
         marker.lng ship.longitude
         marker.picture({
           "url" => view_context.image_path('rocket_pointer.png'),
           "width" => 64,
           "height" => 64
         })
         marker.infowindow render_to_string(partial: "/ships/map_box", locals: { ship: ship })
    end
  end
end
