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

ActiveRecord::Schema.define(version: 20150925091108) do

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "post_id", limit: 4
    t.boolean "like",    limit: 1
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.string   "status",      limit: 255
    t.string   "video_id",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",     limit: 4
    t.integer  "cat_id",      limit: 4
    t.integer  "viewed",      limit: 4
    t.integer  "liked",       limit: 4
    t.integer  "disliked",    limit: 4
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",     limit: 4
    t.integer  "post_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "taggings", ["post_id"], name: "index_taggings_on_post_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "usermetadata", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "post_id",    limit: 4
    t.boolean  "like",       limit: 1
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "role_id",         limit: 4
    t.boolean  "email_confirmed", limit: 1,   default: false
    t.string   "confirm_token",   limit: 255
  end

  add_foreign_key "taggings", "posts"
  add_foreign_key "taggings", "tags"
end
