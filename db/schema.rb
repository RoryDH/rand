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

ActiveRecord::Schema.define(version: 20140317141958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rand_stats", force: true do |t|
    t.integer  "user_id"
    t.integer  "num"
    t.string   "ip"
    t.datetime "j_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_agent"
    t.integer  "list_index"
  end

  add_index "rand_stats", ["list_index"], name: "index_rand_stats_on_list_index", using: :btree
  add_index "rand_stats", ["num"], name: "index_rand_stats_on_num", using: :btree
  add_index "rand_stats", ["user_id"], name: "index_rand_stats_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
