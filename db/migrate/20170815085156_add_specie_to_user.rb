class AddSpecieToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :specie, foreign_key: true
  end
end
