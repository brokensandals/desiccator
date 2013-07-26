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

ActiveRecord::Schema.define(version: 20130726132103) do

  create_table "repos", force: true do |t|
    t.integer "user_id"
    t.string  "name"
    t.text    "default_reviewers"
    t.string  "default_review_duration"
  end

  add_index "repos", ["user_id", "name"], name: "index_repos_on_user_id_and_name", unique: true

  create_table "reviewers", force: true do |t|
    t.integer  "review_id"
    t.integer  "user_id"
    t.datetime "completed_at"
  end

  add_index "reviewers", ["review_id", "user_id"], name: "index_reviewers_on_review_id_and_user_id", unique: true

  create_table "reviews", force: true do |t|
    t.integer  "repo_id"
    t.string   "state"
    t.integer  "pull_number"
    t.text     "title"
    t.datetime "due_at"
  end

  add_index "reviews", ["repo_id", "pull_number"], name: "index_reviews_on_repo_id_and_pull_number", unique: true

  create_table "users", force: true do |t|
    t.text    "name"
    t.string  "login"
    t.string  "image_url"
    t.boolean "crawl_repos", default: false, null: false
  end

  add_index "users", ["crawl_repos"], name: "index_users_on_crawl_repos"
  add_index "users", ["login"], name: "index_users_on_login", unique: true

end
