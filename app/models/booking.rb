class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ship
  validates :start_at, presence: true, :uniqueness => { :scope => [:end_at, :start_at] }
  validates :end_at, presence: true, :uniqueness => { :scope => [:end_at, :start_at] }
  validates :ship_id, presence: true
  validates :user_id, presence: true
  validate :start_at_cannot_be_in_the_past, :end_at_must_be_greater_than_start_at

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
end
