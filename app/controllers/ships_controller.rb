class ShipsController < ApplicationController
	def show
	  @ship = Ship.find(params[:id])
	  @booking = Booking.new
	end

	def index
		@ships = if params[:city]
			# get the query string from the params
			@address = params[:city]
			@ships_info = params[:category]
			# access the ship_class from the ShipsInfo model
			@ship_class = ShipsInfo.find(@ships_info).ship_class
			# query the database
			@ships = Ship.joins(:ships_info).where("address LIKE ?", "%#{@address}%").where("ships_infos.ship_class LIKE ?", "%#{@ship_class}%")
		else
			Ship.all
		end
	end

	private

	def ships_params
		params.require(:ship).permit(:name, :address, :price, :ship_info_id, :user_id)
	end
end
