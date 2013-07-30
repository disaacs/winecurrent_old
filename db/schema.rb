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

ActiveRecord::Schema.define(version: 20130719022325) do

  create_table "reviews", force: true do |t|
    t.integer  "wine_id"
    t.string   "reviewer"
    t.decimal  "score",      precision: 2, scale: 1
    t.text     "review"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wines", force: true do |t|
    t.string   "name"
    t.string   "varietal"
    t.string   "tags"
    t.string   "vintage"
    t.string   "producer"
    t.string   "origin"
    t.string   "appellation"
    t.decimal  "alcohol",         precision: 4, scale: 2
    t.string   "lcbo"
    t.decimal  "price",           precision: 7, scale: 2
    t.string   "image_thumb_url"
    t.string   "availability"
    t.string   "size_in_ml"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
