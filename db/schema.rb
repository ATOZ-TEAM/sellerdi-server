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

ActiveRecord::Schema.define(version: 2021_09_16_193725) do

  create_table "bank_accounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "account_num"
    t.string "bank_name"
    t.string "holder_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
  end

  create_table "exchange_info_request_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "requested_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "exchange_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "exchange_info_request_log_id", null: false
    t.string "symbol"
    t.virtual "currency", type: :string, as: "substr(`symbol`,1,3)", stored: true
    t.string "name"
    t.float "price"
    t.datetime "date"
    t.integer "timestamp"
    t.string "kr"
    t.string "en"
    t.string "jp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exchange_info_request_log_id"], name: "index_exchange_infos_on_exchange_info_request_log_id"
  end

  create_table "markets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "country_code"
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_of_receivable_documents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "receivable_document_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_of_receivable_documents_on_order_id"
    t.index ["receivable_document_id"], name: "index_order_of_receivable_documents_on_receivable_document_id"
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.string "first_item_img"
    t.datetime "date"
    t.string "order_id"
    t.text "transaction_data"
    t.string "status_message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_id"], name: "index_orders_on_shop_id"
  end

  create_table "receivable_bonds", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "receivable_document_id", null: false
    t.date "issue_date"
    t.date "maturity_date"
    t.float "par_value"
    t.float "coupon_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receivable_document_id"], name: "index_receivable_bonds_on_receivable_document_id"
  end

  create_table "receivable_documents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.bigint "bank_account_id", null: false
    t.datetime "released_at"
    t.text "received_bank_account"
    t.integer "order_count", default: 0, null: false
    t.float "order_amount_sum", default: 0.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_account_id"], name: "index_receivable_documents_on_bank_account_id"
    t.index ["shop_id"], name: "index_receivable_documents_on_shop_id"
  end

  create_table "receivable_transactions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "receivable_document_id", null: false
    t.string "start_currency"
    t.float "start_amount"
    t.string "final_currency"
    t.float "final_amount"
    t.float "currency_ratio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receivable_document_id"], name: "index_receivable_transactions_on_receivable_document_id"
  end

  create_table "shops", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "market_id", null: false
    t.string "account"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["market_id"], name: "index_shops_on_market_id"
    t.index ["user_id"], name: "index_shops_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bank_accounts", "users"
  add_foreign_key "exchange_infos", "exchange_info_request_logs"
  add_foreign_key "order_of_receivable_documents", "orders"
  add_foreign_key "order_of_receivable_documents", "receivable_documents"
  add_foreign_key "orders", "shops"
  add_foreign_key "receivable_bonds", "receivable_documents"
  add_foreign_key "receivable_documents", "bank_accounts"
  add_foreign_key "receivable_documents", "shops"
  add_foreign_key "receivable_transactions", "receivable_documents"
  add_foreign_key "shops", "markets"
  add_foreign_key "shops", "users"
end
