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

ActiveRecord::Schema[7.2].define(version: 2025_02_06_151543) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alcohol_logs", force: :cascade do |t|
    t.datetime "check_time", null: false
    t.integer "confirmation", null: false
    t.boolean "detector_used", default: true, null: false
    t.float "result", null: false
    t.integer "condition", null: false
    t.text "log_remarks"
    t.bigint "user_id", null: false
    t.bigint "car_id", null: false
    t.integer "driving_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_alcohol_logs_on_car_id"
    t.index ["user_id"], name: "index_alcohol_logs_on_user_id"
  end

  create_table "approvals", force: :cascade do |t|
    t.date "request_date", null: false
    t.date "acquisition_date", null: false
    t.boolean "paid_applicable", default: false, null: false
    t.bigint "user_id", null: false
    t.bigint "paid_leave_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "paid_remarks"
    t.index ["paid_leave_id"], name: "index_approvals_on_paid_leave_id"
    t.index ["user_id"], name: "index_approvals_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.text "company_car"
    t.text "private_car"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "grants", force: :cascade do |t|
    t.integer "granted_piece", null: false
    t.date "granted_day", null: false
    t.bigint "user_id", null: false
    t.bigint "paid_leave_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paid_leave_id"], name: "index_grants_on_paid_leave_id"
    t.index ["user_id"], name: "index_grants_on_user_id"
  end

  create_table "paid_leaves", force: :cascade do |t|
    t.date "joining_date", null: false
    t.date "base_date", null: false
    t.boolean "part_time", default: false, null: false
    t.integer "classification"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_paid_leaves_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.date "request_date", null: false
    t.date "acquisition_date", null: false
    t.bigint "user_id", null: false
    t.bigint "paid_leave_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "paid_remarks"
    t.index ["paid_leave_id"], name: "index_requests_on_paid_leave_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.integer "department", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "alcohol_logs", "cars"
  add_foreign_key "alcohol_logs", "users"
  add_foreign_key "approvals", "paid_leaves", column: "paid_leave_id"
  add_foreign_key "approvals", "users"
  add_foreign_key "cars", "users"
  add_foreign_key "grants", "paid_leaves", column: "paid_leave_id"
  add_foreign_key "grants", "users"
  add_foreign_key "paid_leaves", "users"
  add_foreign_key "requests", "paid_leaves", column: "paid_leave_id"
  add_foreign_key "requests", "users"
end
