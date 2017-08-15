class ShipsController < ApplicationController
	def index
		# get the query string from the params and do the search
		# supprimer l'utf8 de la query et mettre query
		@ships = if params[:address]
			Ship.where("name LIKE ?", "%#{params[:address]}%")
		else
			Ship.all
		end
	end

	private

	def ships_params
		params.require(:ship).permit(:name, :address, :price, :ship_info_id, :user_id)
	end
end
