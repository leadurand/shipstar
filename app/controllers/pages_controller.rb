class PagesController < ApplicationController
  def home
  	@ship = Ship.new
  	@ships = Ship.all
    @hash = Gmaps4rails.build_markers(@ships) do |ship, marker|
         marker.lat ship.latitude
         marker.lng ship.longitude
         # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end
end
