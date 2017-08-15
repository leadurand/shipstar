class AddRatingToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :rating, :float
  end
end
