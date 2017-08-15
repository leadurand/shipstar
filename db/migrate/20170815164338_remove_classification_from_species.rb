class RemoveClassificationFromSpecies < ActiveRecord::Migration[5.0]
  def change
    remove_column :species, :classification
  end
end
