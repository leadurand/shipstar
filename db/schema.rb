# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170818091720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "user_id"
    t.integer  "ship_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.float    "rating"
    t.text     "content"
    t.boolean  "approved",   default: false
    t.index ["ship_id"], name: "index_bookings_on_ship_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
  end

  create_table "planets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ships", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "price"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "ships_info_id"
    t.integer  "ships_model_id"
    t.float    "latitude"
    t.float    "longitude"
    t.index ["ships_info_id"], name: "index_ships_on_ships_info_id", using: :btree
    t.index ["ships_model_id"], name: "index_ships_on_ships_model_id", using: :btree
    t.index ["user_id"], name: "index_ships_on_user_id", using: :btree
  end

  create_table "ships_classes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ships_infos", force: :cascade do |t|
    t.string   "name"
    t.string   "ship_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ships_models", force: :cascade do |t|
    t.string   "name"
    t.integer  "ships_class_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "image"
    t.index ["ships_class_id"], name: "index_ships_models_on_ships_class_id", using: :btree
  end

  create_table "species", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "species_class_id"
    t.index ["species_class_id"], name: "index_species_on_species_class_id", using: :btree
  end

  create_table "species_classes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "planet_id"
    t.integer  "specie_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["planet_id"], name: "index_users_on_planet_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["specie_id"], name: "index_users_on_specie_id", using: :btree
  end

  add_foreign_key "bookings", "ships"
  add_foreign_key "bookings", "users"
  add_foreign_key "ships", "ships_infos"
  add_foreign_key "ships", "ships_models"
  add_foreign_key "ships", "users"
  add_foreign_key "ships_models", "ships_classes"
  add_foreign_key "species", "species_classes"
  add_foreign_key "users", "planets"
  add_foreign_key "users", "species", column: "specie_id"
end
