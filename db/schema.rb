# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_28_010727) do

  create_table "cuisines", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "menu_link"
    t.string "website"
    t.string "yelp_page"
    t.string "hours"
    t.string "phone"
    t.text "about"
    t.string "neighborhood"
    t.boolean "credit_card"
    t.boolean "reservations"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "star_rating"
    t.string "desc", default: " "
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "restaurant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "password"
  end

end
