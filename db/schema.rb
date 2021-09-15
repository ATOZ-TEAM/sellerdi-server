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

ActiveRecord::Schema.define(version: 2021_09_15_074723) do

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

  add_foreign_key "exchange_infos", "exchange_info_request_logs"
end
