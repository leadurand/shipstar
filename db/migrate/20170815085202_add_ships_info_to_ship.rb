class AddShipsInfoToShip < ActiveRecord::Migration[5.0]
  def change
    add_reference :ships, :ships_info, foreign_key: true
  end
end
