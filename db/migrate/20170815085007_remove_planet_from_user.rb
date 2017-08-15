class RemovePlanetFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :planet, :string
  end
end
