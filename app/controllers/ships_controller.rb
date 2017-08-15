class ShipsController < ApplicationController
	def show
	  @ship = Ship.find(params[:id])
	  @booking = Booking.new
	end
	def index
		# get the query string from the params and do the search
		@address = params[:search]
		@ships = Ship.where("address LIKE ?", "%#{@address}%")
	end

	private

	def ships_params
		params.require(:ship).permit(:name, :address, :price, :ship_info_id, :user_id)
	end
end
