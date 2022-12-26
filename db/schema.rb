# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_26_202411) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default", default: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "description", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "parent_category_id"
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "limit", null: false
    t.integer "billing_day", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "financial_institutions", force: :cascade do |t|
    t.string "name", null: false
    t.string "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.string "encrypted_token", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["encrypted_token"], name: "index_refresh_tokens_on_encrypted_token", unique: true
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "jwt_id", null: false
    t.integer "status", null: false
    t.datetime "expiry_at", precision: nil, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jwt_id"], name: "index_tokens_on_jwt_id", unique: true
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "description", null: false
    t.decimal "amount", null: false
    t.date "spent_at", null: false
    t.integer "transaction_type", null: false
    t.bigint "category_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["category_id"], name: "index_transactions_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "categories", "categories", column: "parent_category_id"
  add_foreign_key "categories", "users"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "refresh_tokens", "users"
  add_foreign_key "tokens", "users"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "categories"
end
