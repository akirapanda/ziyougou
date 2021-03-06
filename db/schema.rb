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

ActiveRecord::Schema.define(version: 20141202033459) do

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "discount_codes", force: true do |t|
    t.integer  "discount_event_id"
    t.integer  "user_id"
    t.string   "image"
    t.string   "code"
    t.date     "begin_at"
    t.date     "end_at"
    t.string   "name"
    t.string   "passport_no"
    t.string   "gender"
    t.date     "leave_at"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mobile"
    t.string   "aasm_state"
    t.datetime "canceled_at"
    t.string   "hk_passport_no"
    t.string   "tw_passport_no"
    t.string   "out_fly_no"
    t.string   "in_fly_no"
    t.date     "back_at"
  end

  create_table "discount_events", force: true do |t|
    t.integer  "shop_id"
    t.string   "name"
    t.string   "intro"
    t.text     "content",              limit: 2147483647
    t.string   "event_type"
    t.date     "begin_at"
    t.date     "end_at"
    t.datetime "publish_at"
    t.boolean  "is_visible",                              default: true
    t.integer  "discount_codes_count"
    t.string   "ticket_image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "discount_info"
  end

  create_table "nations", force: true do |t|
    t.string   "name"
    t.string   "flag_filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommend_events", force: true do |t|
    t.string   "title"
    t.string   "cover"
    t.string   "brief"
    t.text     "content",      limit: 2147483647
    t.boolean  "is_recommend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sellers", force: true do |t|
    t.string   "name"
    t.string   "logo"
    t.string   "intro"
    t.text     "content",     limit: 2147483647
    t.integer  "rate"
    t.integer  "shops_count",                    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nation_id"
  end

  create_table "settings", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shops", force: true do |t|
    t.string   "area"
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "logo"
    t.integer  "seller_id"
    t.text     "content",       limit: 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business_time"
    t.text     "traffic_info"
    t.integer  "nation_id"
  end

  create_table "trip_guides", force: true do |t|
    t.string   "title"
    t.string   "cover"
    t.string   "place_name"
    t.string   "brief"
    t.string   "author"
    t.text     "content",      limit: 2147483647
    t.boolean  "is_recommend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_open_ids", force: true do |t|
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "mobile"
    t.string   "password"
    t.string   "salt"
    t.integer  "point"
    t.decimal  "balance_amount", precision: 10, scale: 0
    t.string   "name"
    t.string   "passport_no"
    t.string   "gender"
    t.string   "status"
    t.string   "last_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "open_id"
    t.string   "reset_token"
    t.datetime "reset_token_at"
  end

  create_table "wx_users", force: true do |t|
    t.string   "open_id"
    t.string   "nickname"
    t.string   "area"
    t.string   "gender"
    t.string   "status"
    t.datetime "last_msg_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
