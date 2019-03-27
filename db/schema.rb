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

ActiveRecord::Schema.define(version: 2019_03_27_022603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budget_items", force: :cascade do |t|
    t.string "description", null: false
    t.decimal "amount", null: false
    t.decimal "min_amount", null: false
    t.bigint "budget_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_budget_items_on_budget_id"
    t.index ["category_id"], name: "index_budget_items_on_category_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string "description", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_categories_users_on_category_id"
    t.index ["user_id"], name: "index_categories_users_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "description", null: false
    t.decimal "amount", null: false
    t.date "spent_on", null: false
    t.integer "payment_method", null: false
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_expenses_on_category_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "budget_items", "budgets"
  add_foreign_key "budget_items", "categories"
  add_foreign_key "budgets", "users"
  add_foreign_key "categories_users", "categories"
  add_foreign_key "categories_users", "users"
  add_foreign_key "expenses", "categories"
  add_foreign_key "expenses", "users"
end
