class DropShipsClassesTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :ships_classes
  end
end
