class ShipsController < ApplicationController
	def show
	  @ship = Ship.find(params[:id])
	  @booking = Booking.new
    @ships = []
    @ships << @ship
    @hash = Gmaps4rails.build_markers(@ships) do |ship, marker|
      marker.lat ship.latitude
      marker.lng ship.longitude
      marker.picture({
        "url" => view_context.image_path('rocket_pointer.png'),
        "width" => 64,
        "height" => 64
      })
    end
	end

	def index

    @address = params[:index][:address] unless params[:index].nil?
    @class = params[:index][:ships_class] unless params[:index].nil?
    @ships = Ship.all

    # Search bar, all possibilities for both fields of the form :

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

  def my_ships
    @ships = Ship.where("user_id = ?", current_user.id).order('created_at DESC')
  end

  def new
    @ship = Ship.new
    @user = User.find(current_user)
  end

  def create
    @ship = Ship.new(ship_params)
    @ship.user_id = current_user.id
    if @ship.save
      redirect_to user_ships_path
    else
      render :new
    end
  end

  private

  def ship_params
    params.require(:ship).permit(:name, :address, :price, :ships_model_id)
  end

  # => Code de Clement sur la barre de recherche

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
