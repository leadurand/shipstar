class AddApprovedToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :approved, :boolean, default: false
  end
end
