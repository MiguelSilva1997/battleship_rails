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

ActiveRecord::Schema.define(version: 2021_05_11_165002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "games", primary_key: "session_id", id: :uuid, default: nil, force: :cascade do |t|
    t.integer "phase", default: 0
    t.string "player_one", null: false
    t.string "player_two", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "next_player"
    t.index ["session_id"], name: "index_games_on_session_id", unique: true
  end

  create_table "ships", force: :cascade do |t|
    t.boolean "is_sunk", default: false
    t.integer "life_points"
    t.integer "ship_type"
    t.string "coordinates"
    t.string "player_id"
    t.string "session_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id", "player_id", "ship_type"], name: "index_ships_on_session_id_and_player_id_and_ship_type", unique: true
  end

end
