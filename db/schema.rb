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

ActiveRecord::Schema.define(version: 20150205211905) do

  create_table "bills", force: true do |t|
    t.float    "value",      limit: 24
    t.integer  "user_id"
    t.integer  "market_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payedby"
    t.string   "note"
  end

  create_table "bills_users", id: false, force: true do |t|
    t.integer "bill_id", null: false
    t.integer "user_id", null: false
  end

  add_index "bills_users", ["bill_id", "user_id"], name: "index_bills_users_on_bill_id_and_user_id", using: :btree
  add_index "bills_users", ["user_id", "bill_id"], name: "index_bills_users_on_user_id_and_bill_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creator"
  end

  create_table "events_users", id: false, force: true do |t|
    t.integer "event_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "events_users", ["event_id", "user_id"], name: "index_events_users_on_event_id_and_user_id", using: :btree
  add_index "events_users", ["user_id", "event_id"], name: "index_events_users_on_user_id_and_event_id", using: :btree

  create_table "flats", force: true do |t|
    t.string   "name"
    t.string   "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "invites", force: true do |t|
    t.string   "email"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flat_id"
  end

  create_table "involved_in_bills", force: true do |t|
    t.integer  "user_id"
    t.integer  "bill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "markets", force: true do |t|
    t.string   "name"
    t.integer  "count"
    t.integer  "voucher"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: true do |t|
    t.string   "name"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "credit"
    t.string   "interval"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flat_id"
  end

  create_table "tasks_users", id: false, force: true do |t|
    t.integer "task_id", null: false
    t.integer "user_id", null: false
  end

  add_index "tasks_users", ["task_id", "user_id"], name: "index_tasks_users_on_task_id_and_user_id", using: :btree
  add_index "tasks_users", ["user_id", "task_id"], name: "index_tasks_users_on_user_id_and_task_id", using: :btree

  create_table "todos", force: true do |t|
    t.string   "task"
    t.boolean  "done",       default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.float    "balance",                limit: 24, default: 0.0,   null: false
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin",                             default: false
    t.integer  "flat_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "working_on_tasks", force: true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "start_time", default: '2015-02-05 21:15:01'
    t.datetime "end_time",   default: '2015-02-19 21:15:01'
    t.boolean  "done",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
