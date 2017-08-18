class Ship < ApplicationRecord
  belongs_to :user # =>owner
  belongs_to :ships_model
  has_many :bookings
  validates :name, presence: true
  validates :address, presence: true
  validates :price, presence: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def daily_rent_price
    (self.price * 0.05).round
  end

  def mean_rating
    if !self.bookings.count.zero?
      sum = 0
      self.bookings.each do |booking|
        sum += booking.rating if !booking.rating.nil?
      end
      (sum / self.bookings.count).round
    end
  end

  def number_of_reviews
    if !self.bookings.count.zero?
      sum = 0
      self.bookings.each do |booking|
        sum += 1 unless booking.rating.nil?
      end
      sum
    end
  end

end
