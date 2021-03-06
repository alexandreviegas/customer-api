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

ActiveRecord::Schema.define(version: 2022_01_04_195637) do

  create_table "bank_accounts", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "bank_code", limit: 3, null: false
    t.string "agency_code", limit: 5, null: false
    t.string "account_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_bank_accounts_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "legal_name", null: false
    t.string "phone_number", null: false
    t.string "address", null: false
    t.string "address_number", limit: 6
    t.string "complement"
    t.string "neighbourhood", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "postal_code", null: false
    t.date "register_date", null: false
    t.decimal "declared_revenues", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bank_accounts", "customers"
end
