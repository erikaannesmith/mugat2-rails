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

ActiveRecord::Schema.define(version: 20180312093840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "designer_comments", force: :cascade do |t|
    t.date "date"
    t.text "body"
    t.bigint "designer_id"
    t.index ["designer_id"], name: "index_designer_comments_on_designer_id"
  end

  create_table "designers", force: :cascade do |t|
    t.string "company"
    t.string "contact"
    t.string "phone"
    t.string "email"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_designers_on_user_id"
  end

  create_table "style_comments", force: :cascade do |t|
    t.date "date"
    t.text "body"
    t.bigint "style_id"
    t.index ["style_id"], name: "index_style_comments_on_style_id"
  end

  create_table "styles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "designer_id"
    t.index ["designer_id"], name: "index_styles_on_designer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

  add_foreign_key "designer_comments", "designers"
  add_foreign_key "designers", "users"
  add_foreign_key "style_comments", "styles"
  add_foreign_key "styles", "designers"
end
