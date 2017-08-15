class AddPlanetToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :planet, foreign_key: true
  end
end
