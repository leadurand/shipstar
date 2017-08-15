class DropShipsModelsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :ships_models
  end
end
