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

ActiveRecord::Schema.define(version: 20140219044631) do

  create_table "adoptions", force: true do |t|
    t.string   "index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adopts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_items", force: true do |t|
    t.integer  "animal_id"
    t.integer  "checkout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",         default: 1
    t.integer  "foster_parent_id"
  end

  add_index "animal_items", ["animal_id"], name: "index_animal_items_on_animal_id"
  add_index "animal_items", ["checkout_id"], name: "index_animal_items_on_checkout_id"
  add_index "animal_items", ["foster_parent_id"], name: "index_animal_items_on_foster_parent_id"

  create_table "animals", force: true do |t|
    t.string   "name"
    t.string   "image_url"
    t.text     "description"
    t.integer  "age"
    t.string   "breed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buys", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkouts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foster_parents", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.integer  "animal_id"
    t.integer  "adopt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["adopt_id"], name: "index_line_items_on_adopt_id"
  add_index "line_items", ["animal_id"], name: "index_line_items_on_animal_id"

end
