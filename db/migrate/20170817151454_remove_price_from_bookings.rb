class RemovePriceFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :price, :integer
  end
end
