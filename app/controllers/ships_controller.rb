class ShipsController < ApplicationController
	def show
	  @ship = Ship.find(params[:id])
	  @booking = Booking.new
	end
	def index
		# get the query string from the params and do the search
		@address = params[:city]
		@ships_info = params[:category]
		@ship_class = ShipsInfo.find(@ships_info).ship_class
		@ships = Ship.joins(:ships_info).where("address LIKE ?", "%#{@address}%").where("ships_infos.ship_class LIKE ?", "%#{@ship_class}%")
	end

	private

	def ships_params
		params.require(:ship).permit(:name, :address, :price, :ship_info_id, :user_id)
	end
end
