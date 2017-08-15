class ShipsModel < ApplicationRecord
  belongs_to :ships_class
  has_many :ships
end
