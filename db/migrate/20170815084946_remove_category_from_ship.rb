class RemoveCategoryFromShip < ActiveRecord::Migration[5.0]
  def change
    remove_column :ships, :category, :string
  end
end
