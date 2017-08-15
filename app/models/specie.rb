class Specie < ApplicationRecord
  has_many :users
  belongs_to :species_class
end
