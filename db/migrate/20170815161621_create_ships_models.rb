class CreateShipsModels < ActiveRecord::Migration[5.0]
  def change
    create_table :ships_models do |t|
      t.string :name
      t.references :ships_class, foreign_key: true

      t.timestamps
    end
  end
end
