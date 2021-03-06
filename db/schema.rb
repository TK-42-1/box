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

ActiveRecord::Schema.define(version: 20190904185220) do

  create_table "boxes", force: true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.string   "month"
    t.string   "year"
    t.string   "destroy_by"
    t.string   "stored_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "department_id"
    t.string   "location_code"
    t.datetime "destroyed_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "retain"
    t.boolean  "indef"
  end

  create_table "divisions", force: true do |t|
    t.integer  "company_id"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "divisions", ["company_id"], name: "index_divisions_on_company_id", using: :btree
  add_index "divisions", ["department_id", "company_id"], name: "index_divisions_on_department_id_and_company_id", unique: true, using: :btree
  add_index "divisions", ["department_id"], name: "index_divisions_on_department_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "code"
    t.string   "room"
    t.string   "row"
    t.string   "section"
    t.string   "shelf"
    t.string   "slot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracer_plus_infos", force: true do |t|
    t.integer  "box_code"
    t.integer  "warehouse_code"
    t.datetime "destroyed_at"
    t.string   "username"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at"
    t.boolean  "synchronized",   default: false, null: false
    t.string   "error"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
