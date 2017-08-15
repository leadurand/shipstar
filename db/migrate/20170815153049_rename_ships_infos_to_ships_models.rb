class RenameShipsInfosToShipsModels < ActiveRecord::Migration[5.0]
  def change
    rename_table :ships_infos, :ships_models
  end
end
