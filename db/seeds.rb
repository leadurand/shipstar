# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

def serialized(element)
  JSON.parse(element)
end

def species
  species = serialized(Swapi.get_all("species"))
  all_species = []

  species["results"].each do |h|
    all_species << h["name"]
  end
  all_species
end

def planets
  planets = serialized(Swapi.get_all("planets"))
  all_planets = []

  planets["results"].each do |h|
    all_planets << h["name"]
  end
  all_planets
end

def serialized(element)
  JSON.parse(element)
end


planets
species

# 1.upto(10) do |n|
#   person = serialized(Swapi.get_person(n))
#   planet = serialized(open(person["homeworld"]).read)
#   species = serialized(open(person["species"].first).read)

#   User.create!(
#     name: person["name"],
#     planet: planet["name"],
#     species: species["name"]
#   )
# end



# fake_ship = Swapi.get_vehicle(4)



# name = user["results"][0]["name"]
