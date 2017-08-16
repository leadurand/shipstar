class ShipsController < ApplicationController
	def show
	  @ship = Ship.find(params[:id])
	  @booking = Booking.new
	end

	def index
		@ships = if params[:country]
			# get the query string from the params
			@address = params[:country]
			@ships_class_id = params[:class]
			# access the ship_class from the ShipsInfo model
			@ships_class_name = ShipsClass.find(@ships_class_id.to_i).name
			# query the database !!! TO FIX
			@all_ships = Ship.where(address: @address)
			@ships = @all_ships.select do |ship|
				ship.ships_model.ships_class.name == @ships_class_name
			end
			# @ships = Ship.joins(ships_model: :ships_class).where(address: @address).where('ships_class.name' => @ships_class_name)
			# @ships = Ship.joins(:ships_model, :ships_class).where("address LIKE ?", "%#{@address}%").where("ships_classes.name LIKE ?", "%#{@ships_class_name}%")
		else
			Ship.all
		end
	end

	private

	def ships_params
		params.require(:ship).permit(:name, :address, :price, :ship_model_id, :user_id)
	end
end