class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ship
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :ship_id, presence: true, :uniqueness => { :scope => [:end_at, :start_at] }
  validates :user_id, presence: true
end
