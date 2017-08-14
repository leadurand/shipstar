class User < ApplicationRecord
  has_many :bookings
  has_many :ships # => his own ships
  validates :name, presence: true, uniqueness: true
  # ajouter collection pour :species & :planet => seed
  validates :species, inclusion: { in: ['Anx', 'Humain', 'Jedi', 'Ewok', 'Droid'], allow_nil: false }
  validates :planet, presence: true, inclusion: { in: ['Tatawin', 'Pipada', 'Kamino', 'Dagobah'], allow_nil: false }
end
