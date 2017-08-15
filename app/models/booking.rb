class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ship
  validates :start_at, presence: true, :uniqueness => { :scope => [:end_at, :start_at] }
  validates :end_at, presence: true, :uniqueness => { :scope => [:end_at, :start_at] }
  validates :ship_id, presence: true
  validates :user_id, presence: true
end
