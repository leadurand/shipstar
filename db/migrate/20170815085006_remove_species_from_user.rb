class RemoveSpeciesFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :species, :string
  end
end
