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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120115215045) do

  create_table "coins", :force => true do |t|
    t.string   "nominal_value",      :limit => 4, :null => false
    t.integer  "country_id",                      :null => false
    t.integer  "commemorative_year"
    t.string   "image_file_name",                 :null => false
    t.string   "image_content_type",              :null => false
    t.integer  "image_file_size",                 :null => false
    t.datetime "collected_at"
    t.string   "collected_by"
    t.string   "type",                            :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "code",       :limit => 10, :null => false
    t.string   "name",       :limit => 32, :null => false
    t.string   "genitive",   :limit => 32, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "identifier_url",                                 :null => false
    t.string   "email",                                          :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active",                      :default => false, :null => false
    t.integer  "roles_mask",     :limit => 8, :default => 0,     :null => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

end
