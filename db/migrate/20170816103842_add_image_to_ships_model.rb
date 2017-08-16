class AddImageToShipsModel < ActiveRecord::Migration[5.0]
  def change
    add_column :ships_models, :images, :string
  end
end
