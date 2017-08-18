class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ship
  validates :start_at, presence: true, :uniqueness => { :scope => [:end_at, :start_at] }
  validates :end_at, presence: true, :uniqueness => { :scope => [:end_at, :start_at] }
  validates :ship_id, presence: true
  validates :user_id, presence: true
  validate :start_at_cannot_be_in_the_past, :end_at_must_be_greater_than_start_at, :length_must_be_over_one_day

  def start_at_cannot_be_in_the_past
    if start_at.present? && start_at < Date.today
      errors.add(:start_at, "You cannot rent in the past!")
    end
  end

  def end_at_must_be_greater_than_start_at
    if end_at < start_at
      errors.add(:end_at, "End date should be greater than Start date!")
    end
  end

  def length_must_be_over_one_day
    if self.length < 1
      errors.add(:end_at, "Your booking should be over one day!")
    end
  end

  def length
    (self.end_at - self.start_at) / 86400
  end

  def price
    (self.ship.daily_rent_price * self.length).round
  end

end
