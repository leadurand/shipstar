class RemoveShipsInfoFromShips < ActiveRecord::Migration[5.0]
  def change
    remove_column :ships, :ships_info_id
  end
end
