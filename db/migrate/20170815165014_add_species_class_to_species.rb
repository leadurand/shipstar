class AddSpeciesClassToSpecies < ActiveRecord::Migration[5.0]
  def change
    add_reference :species, :species_class, foreign_key: true
  end
end
