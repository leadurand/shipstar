class AddContentToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :content, :text
  end
end
