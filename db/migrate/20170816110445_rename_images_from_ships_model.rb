class RenameImagesFromShipsModel < ActiveRecord::Migration[5.0]
  def change
      rename_column :ships_models, :images, :image
  end
end
