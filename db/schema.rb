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

ActiveRecord::Schema.define(version: 2020_08_23_231645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "deposits", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "BZD", null: false
    t.bigint "recorded_by_id"
    t.index ["order_id"], name: "index_deposits_on_order_id"
    t.index ["recorded_by_id"], name: "index_deposits_on_recorded_by_id"
    t.index ["user_id"], name: "index_deposits_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "image"
    t.integer "imageable_id"
    t.string "imageable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_items", force: :cascade do |t|
    t.bigint "invoice_id"
    t.bigint "order_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_price_cents", default: 0, null: false
    t.string "unit_price_currency", default: "BZD", null: false
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "BZD", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BZD", null: false
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
    t.index ["order_item_id"], name: "index_invoice_items_on_order_item_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sub_total_cents", default: 0, null: false
    t.string "sub_total_currency", default: "BZD", null: false
    t.integer "shipping_fee_cents", default: 0, null: false
    t.string "shipping_fee_currency", default: "BZD", null: false
    t.integer "delivery_fee_cents", default: 0, null: false
    t.string "delivery_fee_currency", default: "BZD", null: false
    t.integer "service_charge_cents", default: 0, null: false
    t.string "service_charge_currency", default: "BZD", null: false
    t.integer "sales_tax_cents", default: 0, null: false
    t.string "sales_tax_currency", default: "BZD", null: false
    t.integer "discount_cents", default: 0, null: false
    t.string "discount_currency", default: "BZD", null: false
    t.integer "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "BZD", null: false
    t.integer "public_uid"
    t.index ["order_id"], name: "index_invoices_on_order_id"
    t.index ["public_uid"], name: "index_invoices_on_public_uid"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "listing_id"
    t.bigint "cart_id"
    t.boolean "is_listing", default: false
    t.text "link"
    t.text "details"
    t.integer "quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "shipping_rate_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BZD", null: false
    t.decimal "extra_pounds"
    t.boolean "local_pickup", default: false
    t.index ["cart_id"], name: "index_line_items_on_cart_id"
    t.index ["listing_id"], name: "index_line_items_on_listing_id"
    t.index ["shipping_rate_id"], name: "index_line_items_on_shipping_rate_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.text "requirements"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BZD", null: false
    t.bigint "shipping_rate_id"
    t.index ["shipping_rate_id"], name: "index_listings_on_shipping_rate_id"
    t.index ["slug"], name: "index_listings_on_slug", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.text "link"
    t.text "details"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BZD", null: false
    t.bigint "shipping_rate_id"
    t.decimal "extra_pounds"
    t.boolean "local_pickup", default: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["shipping_rate_id"], name: "index_order_items_on_shipping_rate_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.string "contact_number"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "status", default: 0
    t.integer "tracking_number"
    t.bigint "schedule_id"
    t.boolean "archive", default: false
    t.datetime "invoice_emailed_at"
    t.boolean "draft", default: false
    t.index ["schedule_id"], name: "index_orders_on_schedule_id"
    t.index ["tracking_number"], name: "index_orders_on_tracking_number"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.date "departure"
    t.date "arrival"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arrival"], name: "index_schedules_on_arrival", unique: true
    t.index ["departure"], name: "index_schedules_on_departure", unique: true
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "shipping_rates", force: :cascade do |t|
    t.string "name"
    t.decimal "min_order_weight"
    t.decimal "max_order_weight"
    t.boolean "free_shipping", default: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_order_price_cents", default: 0, null: false
    t.string "min_order_price_currency", default: "BZD", null: false
    t.integer "max_order_price_cents", default: 0, null: false
    t.string "max_order_price_currency", default: "BZD", null: false
    t.integer "rate_amount_cents", default: 0, null: false
    t.string "rate_amount_currency", default: "BZD", null: false
  end

  create_table "slides", force: :cascade do |t|
    t.string "main_title"
    t.string "sub_title"
    t.string "link_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link_text"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.integer "public_uid"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.boolean "allow_password_change", default: true
    t.json "tokens"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["public_uid"], name: "index_users_on_public_uid"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "carts", "users"
  add_foreign_key "deposits", "orders"
  add_foreign_key "deposits", "users"
  add_foreign_key "deposits", "users", column: "recorded_by_id"
  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoice_items", "order_items"
  add_foreign_key "invoices", "orders"
  add_foreign_key "invoices", "users"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "listings"
  add_foreign_key "line_items", "shipping_rates"
  add_foreign_key "listings", "shipping_rates"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "shipping_rates"
  add_foreign_key "orders", "schedules"
  add_foreign_key "orders", "users"
end
