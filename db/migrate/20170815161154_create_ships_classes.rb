class CreateShipsClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :ships_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end
