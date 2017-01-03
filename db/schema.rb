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

ActiveRecord::Schema.define(version: 20161214213932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cultural_opinions", force: :cascade do |t|
    t.integer  "opinion_of_culture_id"
    t.integer  "opinion_about_culture_id"
    t.integer  "value"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "cultures", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "populations", force: :cascade do |t|
    t.integer  "province_id"
    t.integer  "culture_id"
    t.integer  "quantity",    default: 0
    t.integer  "happiness",   default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "focus",       default: 0
    t.index ["culture_id"], name: "index_populations_on_culture_id", using: :btree
    t.index ["province_id"], name: "index_populations_on_province_id", using: :btree
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name"
    t.integer  "terrain",    default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "state_id"
    t.index ["state_id"], name: "index_provinces_on_state_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "populations", "cultures"
  add_foreign_key "populations", "provinces"
  add_foreign_key "provinces", "states"
end
