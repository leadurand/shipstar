class CreateShipsInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :ships_infos do |t|
      t.string :name
      t.string :ship_class

      t.timestamps
    end
  end
end
