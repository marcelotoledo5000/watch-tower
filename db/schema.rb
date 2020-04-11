# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_11_174428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "visitor_id", null: false
    t.bigint "store_id", null: false
    t.integer "kind", default: 0, null: false
    t.datetime "event_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_appointments_on_store_id"
    t.index ["visitor_id"], name: "index_appointments_on_visitor_id"
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "stores", force: :cascade do |t|
    t.string "cnpj", limit: 14, null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cnpj"], name: "index_stores_on_cnpj", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.bigint "store_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["store_id"], name: "index_users_on_store_id"
  end

  create_table "visitors", force: :cascade do |t|
    t.string "cpf", limit: 11, null: false
    t.string "name", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile_photo", null: false
    t.index ["cpf"], name: "index_visitors_on_cpf", unique: true
    t.index ["store_id"], name: "index_visitors_on_store_id"
  end

  add_foreign_key "appointments", "stores"
  add_foreign_key "appointments", "visitors"
  add_foreign_key "users", "stores"
  add_foreign_key "visitors", "stores"
end
