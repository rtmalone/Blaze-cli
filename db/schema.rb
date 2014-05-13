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

ActiveRecord::Schema.define(version: 20140512031700) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "difficulties", force: true do |t|
    t.string   "class"
    t.string   "class_summary"
    t.string   "tread"
    t.string   "obstacles"
    t.string   "features"
    t.string   "signage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trail_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trails", force: true do |t|
    t.string   "name"
    t.string   "date"
    t.integer  "activity_id"
    t.string   "length"
    t.integer  "difficulty_id"
    t.integer  "trail_type_id"
    t.string   "park"
    t.string   "state"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
