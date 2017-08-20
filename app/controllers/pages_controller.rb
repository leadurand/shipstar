class PagesController < ApplicationController
  def home
  	@users = User.all
    @bookings = Booking.all
    @ship = Ship.new
    # @ships is used to display 3 ships on home page
    # actually not the best way to do it. I should find it with mean_rating method
    # but I cannot access it with ActiveRecord methods. The best solution I found
    # was to find 3 bookings rated 5/5 and select associated ships.
    # It works fine because we have only a few bookings seeded (~100) so there is
    # good chance that a ship that once received a 5/5 still has a great mean_rating.
    @ships = []
  	Booking.where('rating = 5').first(3).each do |booking|
      @ships << booking.ship
    end
    @ships_all = Ship.all
    @hash = Gmaps4rails.build_markers(@ships_all) do |ship, marker|
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
end
