class SetUpDb < ActiveRecord::Migration
  def change
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

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "username"
    t.boolean  "admin",           default: false
    t.string   "company"
    t.string   "department"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree
  end
end
