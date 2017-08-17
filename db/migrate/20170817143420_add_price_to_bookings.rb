class AddPriceToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :price, :integer
  end
end
