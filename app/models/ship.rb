class Ship < ApplicationRecord
  belongs_to :user # =>owner
  has_many :bookings
  validates :name, presence: true
  # validates :category, inclusion: { in: ['Patrol craft', 'Assault Starfighter', 'Deep Space Mobile Battlestation', 'Starfighter', 'landingcraft', 'star dreadnought', 'Armed government transport', 'Escort Ship'], allow_nil: false }
  validates :address, presence: true
  validates :price, presence: true
end
