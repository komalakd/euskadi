# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140304044253) do

  create_table "enterprises", force: true do |t|
    t.string   "cuit"
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_rooms", force: true do |t|
    t.integer  "room_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passengers", force: true do |t|
    t.string   "dni"
    t.string   "name"
    t.string   "lastname"
    t.string   "phone_number"
    t.string   "nationality"
    t.string   "birthdate"
    t.string   "country"
    t.string   "province"
    t.string   "city"
    t.string   "address"
    t.string   "proffesion"
    t.string   "civil_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.decimal  "amount"
    t.string   "reservation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservation_rooms", force: true do |t|
    t.integer  "reservation_id"
    t.integer  "reservation_item_id"
    t.string   "reservation_item_type"
    t.decimal  "amount"
    t.date     "since"
    t.date     "until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: true do |t|
    t.integer  "passenger_id"
    t.integer  "enterprise_id"
    t.decimal  "amount"
    t.text     "observation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_pages", force: true do |t|
    t.integer  "page_id"
    t.integer  "room_id"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_passengers", force: true do |t|
    t.integer  "reservation_room_id"
    t.integer  "passenger_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_types", force: true do |t|
    t.string   "denomination"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", force: true do |t|
    t.integer  "number"
    t.boolean  "active"
    t.decimal  "amount"
    t.integer  "room_type_id"
    t.integer  "group_id"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "password_digest"
    t.string   "email"
    t.string   "name"
    t.string   "lastname"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
