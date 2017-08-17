class ShipsController < ApplicationController
	def show
	  @ship = Ship.find(params[:id])
	  @booking = Booking.new
	end

	def index

    @address = params[:index][:address] unless params[:index].nil?
    @class = params[:index][:ships_class] unless params[:index].nil?
    @ships = Ship.all

    if @class.blank? && @address.blank?
      @ships
      elsif @class != "" && @address.blank?
        @ships = Ship.all.select do |ship|
          ship.ships_model.ships_class.id == @class.to_i
        end
      elsif @class.blank? && @address != ""
        @ships = Ship.where('lower(address) LIKE ?', "%#{@address.downcase}%")
      elsif @class != "" && @address != ""
        @all_ships = Ship.where('lower(address) LIKE ?', "%#{@address.downcase}%")
        @ships = @all_ships.select do |ship|
          ship.ships_model.ships_class.id == @class.to_i
        end
    end

    if @ships == []
      flash.now[:search_error] = "Sorry, no matches..."
    end

  end

	# 	@ships = if params[:country]
	# 		# get the query string from the params
	# 		@address = params[:country]
	# 		@ships_class_id = params[:class]
	# 		# access the ship_class from the ShipsInfo model
	# 		@ships_class_name = ShipsClass.find(@ships_class_id.to_i).name
	# 		# query the database !!! TO FIX
	# 		@all_ships = Ship.where(address: @address)
	# 		@ships = @all_ships.select do |ship|
	# 			ship.ships_model.ships_class.name == @ships_class_name
	# 		end
	# 		# @ships = Ship.joins(ships_model: :ships_class).where(address: @address).where('ships_class.name' => @ships_class_name)
	# 		# @ships = Ship.joins(:ships_model, :ships_class).where("address LIKE ?", "%#{@address}%").where("ships_classes.name LIKE ?", "%#{@ships_class_name}%")
	# 	else
	# 		Ship.all
	# 	end
	# end

end
