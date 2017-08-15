# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

# base method for serialization

def serialized(element)
  JSON.parse(element)
end

# base method for random id of a table

def random(table)
  table.order("RANDOM()").first.id
end

Booking.destroy_all
Ship.destroy_all
User.destroy_all
Specie.destroy_all
Planet.destroy_all
ShipsInfo.destroy_all

# populate species table with API "name" and "classification"

def fetch_db_species(url)
  url.each do |specie|
    Specie.create(name: specie["name"], classification: specie["classification"])
  end
end

species = serialized(open("http://swapi.co/api/species/").read)
while species["next"] != nil
  fetch_db_species(species["results"])
  species = serialized(open(species["next"]).read)
end

  lastspe = serialized(open("http://swapi.co/api/species/?page=4").read)
  fetch_db_species(lastspe["results"])

# populate planets table with API "name"

def fetch_db_planets(url)
  url.each do |planet|
    Planet.create(name: planet["name"])
  end
end

planets = serialized(open("http://swapi.co/api/planets/").read)
while planets["next"] != nil
  fetch_db_planets(planets["results"])
  planets = serialized(open(planets["next"]).read)
end

  lastplan = serialized(open("http://swapi.co/api/planets/?page=7").read)
  fetch_db_planets(lastplan["results"])
#trouver une solution pour faire une derniere boucle... loop do ?

# populate ships-infos table with API "model" and "starship_class"

def fetch_db_shipsinfos(url)
  url.each do |ships_info|
    ShipsInfo.create(name: ships_info["model"], ship_class: ships_info["starship_class"])
  end
end

starships = serialized(open("http://swapi.co/api/starships/").read)
while starships["next"] != nil
  fetch_db_shipsinfos(starships["results"])
  starships = serialized(open(starships["next"]).read)
end

  lastship = serialized(open("http://swapi.co/api/starships/?page=4").read)
  fetch_db_shipsinfos(lastship["results"])

#Create 10 users and get goods planets and species from API and ids from table

1.upto(10) do |n|
  person = serialized(Swapi.get_person(n))
  planet = serialized(open(person["homeworld"]).read)["name"]
  p_id = Planet.find_by(name: planet).id
  specie = serialized(open(person["species"].first).read)["name"]
  s_id = Specie.find_by(name: specie).id

  User.create!(
    name: person["name"],
    planet_id: p_id,
    specie_id: s_id,
    email: Faker::Internet.email,
    password: '123456'
  )
end

# # A la main pour que l'equipe puisse tester, a refacto... en suivant pour plus propre

Ship.create(
  name: "Nasa",
  address: "Cours Balguerie, Bordeaux",
  price: 100,
  ships_info_id: random(ShipsInfo),
  user_id: random(User)
)

Ship.create(
  name: "Wagon",
  address: "Rue Bert, Le Bouscat",
  price: 800,
  ships_info_id: random(ShipsInfo),
  user_id: random(User)
)

Ship.create(
  name: "Titanic",
  address: "4 avenue Thiers, Bordeaux",
  price: 50,
  ships_info_id: random(ShipsInfo),
  user_id: random(User)
)

Ship.create(
  name: "XR45",
  address: "200 avenue Thiers, Bordeaux",
  price: 50,
  ships_info_id: random(ShipsInfo),
  user_id: random(User)
)

Booking.create(
  start_at: "Mon, 14 Aug 2017 21:20:44 UTC +00:00",
  end_at: "Mon, 16 Aug 2017 21:20:44 UTC +00:00",
  user_id: random(User),
  ship_id: random(Ship)
)

Booking.create(
  start_at: "Mon, 11 Aug 2017 21:20:44 UTC +00:00",
  end_at: "Mon, 19 Aug 2017 21:20:44 UTC +00:00",
  user_id: random(User),
  ship_id: random(Ship)
)

Booking.create(
  start_at: "Mon, 10 Aug 2017 21:20:44 UTC +00:00",
  end_at: "Mon, 25 Aug 2017 21:20:44 UTC +00:00",
  user_id: random(User),
  ship_id: random(Ship)
)

Booking.create(
  start_at: "Mon, 17 Aug 2017 21:20:44 UTC +00:00",
  end_at: "Mon, 28 Aug 2017 21:20:44 UTC +00:00",
  user_id: random(User),
  ship_id: random(Ship)
)
