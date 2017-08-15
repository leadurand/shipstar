class AddShipsModelToShips < ActiveRecord::Migration[5.0]
  def change
    add_reference :ships, :ships_model, foreign_key: true
  end
end
