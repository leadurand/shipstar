# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
time = Time.now
puts "Go get yourself a coffee... It's going to be a long ride!"
puts "No hyperspeed here ;) -> Estimated time ~5min"
puts "Btw, did you bundle install & db:migrate? If not, interrupt now and do it!"

# base method for serialization

def serialized(element)
  JSON.parse(element)
end

# base method for random id of a table

def random(table)
  table.order("RANDOM()").first.id
end

# PURGE DB
puts "[PURGE in #{(Time.now - time).round} sec] Let's destroy all our data!"
Booking.destroy_all
Ship.destroy_all
User.destroy_all
Specie.destroy_all
SpeciesClass.destroy_all
Planet.destroy_all
ShipsModel.destroy_all
ShipsClass.destroy_all

# [SPECIES] Populate species table with API "name" and "classification"
puts "[SPECIES in #{(Time.now - time).round} sec] Creating all the species in the galaxy! Feeling like a God?"
def fetch_db_species_classes(url)
  url.each do |specie|
    SpeciesClass.create(name: specie["classification"])
  end
end

def fetch_db_species(url)
  url.each do |specie|
    species_class = SpeciesClass.find_by(name: specie["classification"])
    if species_class.nil?
      next
    else
      species_class_id = species_class.id
      Specie.create(name: specie["name"], species_class_id: species_class_id)
    end
  end
end


species = serialized(open("http://swapi.co/api/species/").read)
while species["next"] != nil
  fetch_db_species_classes(species["results"])
  fetch_db_species(species["results"])
  species = serialized(open(species["next"]).read)
end

lastspe = serialized(open("http://swapi.co/api/species/?page=4").read)
fetch_db_species_classes(lastspe["results"])
fetch_db_species(lastspe["results"])


# [PLANETS] populate planets table with API "name"
puts "[PLANETS in #{(Time.now - time).round} sec] Crafting beautiful planets right now!"

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
# loop do
#   fetch_db_species(species["results"])
#   species = serialized(open(species["next"]).read)
#   break if species["next"].nil?
# end

# [USERS] Create 70 users and get goods planets and species from API and ids from table
puts "[USERS in #{(Time.now - time).round} sec] Here we are! Populating the galaxy :D"
puts "This might take a while..."

users_avatars = [
  "http://icon-icons.com/icons2/1070/PNG/512/ewok_icon-icons.com_76943.png",
  "http://icon-icons.com/icons2/1070/PNG/512/admiral-ackbar_icon-icons.com_76935.png",
  "http://icon-icons.com/icons2/1070/PNG/512/qui-gon-jinn_icon-icons.com_76946.png",
  "https://www.shareicon.net/download/2016/11/21/854798_raider_327x512.png",
  "http://icon-icons.com/icons2/1070/PNG/512/luke-skywalker_icon-icons.com_76939.png",
  "http://icon-icons.com/icons2/1070/PNG/512/yoda_icon-icons.com_76947.png",
  "http://www.iconninja.com/files/632/403/650/princess-leia-icon.svg",
  "https://www.shareicon.net/download/2016/11/21/854777_darth_410x512.png",
  "https://www.shareicon.net/download/2016/11/21/854773_c3p0_432x512.png",
  "http://icon-icons.com/icons2/1070/PNG/512/jawa_icon-icons.com_76960.png",
  "http://www.iconninja.com/files/301/550/552/jabba-the-hutt-icon.svg",
  "http://icon-icons.com/icons2/1070/PNG/512/chewbacca_icon-icons.com_76942.png",
]


1.upto(70) do |n|
  # user #17 does not exist. Surely we might find a better solution...
  if n == 17
    next
  else
    person = serialized(Swapi.get_person(n))
    planet = serialized(open(person["homeworld"]).read)["name"] unless person["homeworld"].empty?
    p_id = Planet.find_by(name: planet).id unless person["homeworld"].empty?
    specie = serialized(open(person["species"].first).read)["name"] unless person["species"].empty?
    s_id = Specie.find_by(name: specie).id unless person["species"].empty?

    User.create!(
      name: person["name"],
      planet_id: p_id,
      specie_id: s_id,
      email: Faker::Internet.email,
      password: '123456',
      avatar: users_avatars.sample
    )
  end
end

# [SHIPS] Next steps -> generate real addresses with reverse/geocoding
# -> fetch real prices of ships to determine rental value
puts "[SHIPS in #{(Time.now - time).round} sec] Designing the best vehicules for our dear clients!"

def fetch_db_ships_classes(url)
  url.each do |ships_class|
    if ShipsClass.find_by(name: ships_class["starship_class"].capitalize).present? == true
      next
    else
      ShipsClass.create(name: ships_class["starship_class"].capitalize)
    end
  end
end

def fetch_db_ships_models(url)
  url.each do |ships_model|
    ships_class = ShipsClass.find_by(name: ships_model["starship_class"].capitalize)
    if ships_class.nil?
      next
    else
      ships_class_id = ships_class.id
      ShipsModel.create(name: ships_model["name"], ships_class_id: ships_class_id)
    end
  end
end


# Why don't we use the gem -> gem 'tatooine' or others?
starships = serialized(open("http://swapi.co/api/starships/").read)
while starships["next"] != nil
  fetch_db_ships_classes(starships["results"])
  fetch_db_ships_models(starships["results"])
  starships = serialized(open(starships["next"]).read)
end

lastship = serialized(open("http://swapi.co/api/starships/?page=4").read)
fetch_db_ships_classes(lastship["results"])
fetch_db_ships_models(lastship["results"])

1.upto(50) do |n|
  Ship.create(
    name: Faker::Space.nasa_space_craft,
    address: Faker::Address.country,
    price: rand(10000..100000),
    ships_model_id: random(ShipsModel),
    user_id: random(User)
  )
end

# [BOOKINGS] -> I modified the generator to be sure that the ship is associated with its owner
puts "[BOOKINGS in #{(Time.now - time).round} sec] Let's do some business!"

1.upto(100) do |n|
  Booking.create(
    #We're so lucky here, Ruby generates the weekday appropriately!
  start_at: "Mon, #{rand(1..15)} Oct 2017 21:20:44 UTC +00:00",
  end_at: "Mon, #{rand(16..31)} Oct 2017 21:20:44 UTC +00:00",
  content: Faker::StarWars.quote,
  rating: rand(3..5),
  user_id: User.all.sample.id,
  ship_id: Ship.all.sample.id,
  approved: true
  )
end

# generate models image in the good order, hope the order of the api ships models will dont change.
# Ideally the best will be to use google image api but it may be too random.

modelsimages = [
  "http://fractalsponge.net/images/gallery/slides/Executor.jpg",
  "https://vignette2.wikia.nocookie.net/firststrikemod/images/f/fd/FSMOD_Sentinel.JPG/revision/latest?cb=20110327181005",
  "https://lumiere-a.akamaihd.net/v1/images/Death-Star-II_b5760154.jpeg?region=0%2C0%2C2160%2C1215&width=768",
  "http://www.gadgetreview.com/wp-content/uploads/2015/05/millennium-falcon.jpg",
  "https://lumiere-a.akamaihd.net/v1/images/Y-Wing-Fighter_0e78c9ae.jpeg?region=0%2C0%2C1536%2C864&width=768",
  "https://static1.squarespace.com/static/566de2b3d8af104b6800e718/t/587b18d79de4bbb43fed8397/1484462330394/Untitled-5.jpg?format=1500w",
  "http://vignette4.wikia.nocookie.net/starwars/images/d/d1/TIE_Advanced.jpg/revision/latest?cb=20071123095737&path-prefix=nl",
  "https://cdn.instructables.com/FMT/8V4P/HFSHT69C/FMT8V4PHFSHT69C.MEDIUM.jpg",
  "https://spikeybits.com/wp-content/uploads/2016/05/lambda-fly1-xwing.jpg",
  "https://vignette2.wikia.nocookie.net/starwars/images/5/50/NBfrigate.JPG/revision/latest?cb=20061215024715",
  "https://vignette2.wikia.nocookie.net/starwars/images/9/94/MCLiberty.jpg/revision/latest?cb=20070104001953",
  "https://vignette2.wikia.nocookie.net/starwars/images/a/aa/Awing-sag.jpg/revision/latest?cb=20120629194348",
  "https://vignette4.wikia.nocookie.net/starwars/images/9/95/B-wing_infly.jpg/revision/latest?cb=20051223162859",
  "http://vignette2.wikia.nocookie.net/swtor/images/b/bd/Republic_Hammerhead_Cruiser_1.jpg/revision/latest?cb=20110405145539",
  "https://vignette3.wikia.nocookie.net/disney-infinity/images/7/7e/N1_fighter.jpg/revision/latest?cb=20150509034743",
  "https://lumiere-a.akamaihd.net/v1/images/databank_nabooroyalstarship_01_169_e61f677e.jpeg?region=0%2C0%2C1560%2C878&width=768",
  "http://fractalsponge.net/images/scimitar_med.jpg",
  "https://s-media-cache-ak0.pinimg.com/564x/45/9f/02/459f029521f5880878938eef539fc9dd.jpg",
  "https://s-media-cache-ak0.pinimg.com/564x/61/9a/be/619abebc4271ac44616ce608f07159a3.jpg",
  "https://lumiere-a.akamaihd.net/v1/images/delta-7-starfighter_fe9a59bc.jpeg?region=0%2C304%2C1560%2C873&width=768",
  "http://4.bp.blogspot.com/-vh-58cG2a5Y/UyWWVEkD6bI/AAAAAAAAEuA/6Lw3YWKIkz4/s1600/Stratios.png",
  "https://vignette2.wikia.nocookie.net/starwars/images/6/6e/VicStarI-EaW.jpg/revision/latest?cb=20061122033436",
  "https://s-media-cache-ak0.pinimg.com/originals/85/17/94/851794703f1a59128398a43a6655e370.jpg",
  "http://pm1.narvii.com/6476/293a4df263229fc2959f2003427138df90a64b49_hq.jpg",
  "https://www.cgstudio.com/imgd/l/85/56e005b661946e6f338b4567/5297.jpg",
  "http://vignette3.wikia.nocookie.net/starwars/images/e/e6/Rebel_transport_box_art.jpg/revision/latest?cb=20140916032031",
  "http://vignette1.wikia.nocookie.net/starwars/images/5/5e/Droid_Control_Ship.png/revision/latest?cb=20130121051230",
  "https://vignette4.wikia.nocookie.net/theclonewiki/images/2/21/Acclamator_FT.jpg/revision/latest?cb=20120208024345",
  "https://vignette1.wikia.nocookie.net/starwars/images/b/b0/SolorSailer-DB.png/revision/latest?cb=20150819020309",
  "https://lumiere-a.akamaihd.net/v1/images/databank_republicattackcruiser_01_169_812f153d.jpeg?region=0%2C0%2C1560%2C780",
  "http://vignette1.wikia.nocookie.net/starwars/images/d/df/Naboo_star_skiff_1.png/revision/latest?cb=20130212042348",
  "https://lumiere-a.akamaihd.net/v1/images/ETA-2-starfighter-main-image_bedd3aaa.jpeg?region=142%2C0%2C1632%2C816",
  "https://vignette3.wikia.nocookie.net/starwars/images/b/ba/ARC170starfighter.jpg/revision/latest?cb=20111112062600",
  "https://vignette2.wikia.nocookie.net/swg/images/5/56/Belbullab-22.JPG/revision/latest?cb=20060622063743",
  "https://vignette4.wikia.nocookie.net/starwars/images/b/bf/CloneFlightSquadSevenVwings.jpg/revision/latest?cb=20120109030042",
  "https://vignette2.wikia.nocookie.net/fr.starwars/images/6/69/Tantive_IV.png/revision/latest?cb=20150323200847",
  "http://www.igorstshirts.com/blog/conceptships/2012/david_llewelyn/dl_01.jpg",
]

  n = 0
ShipsModel.all.each do |model|
  model.image = modelsimages[n]
  model.save
  n +=1
end



puts " DONE in #{(Time.now - time).round} sec"
