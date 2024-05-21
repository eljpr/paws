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

ActiveRecord::Schema[7.1].define(version: 2024_05_21_110909) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.string "medication"
    t.string "condition"
    t.string "breed"
    t.bigint "user_id", null: false
    t.date "date_of_birth"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dogs_on_user_id"
  end

  create_table "logs", force: :cascade do |t|
    t.string "food"
    t.string "medication"
    t.string "special_treat"
    t.string "grooming"
    t.string "stool"
    t.string "vaccination"
    t.bigint "dog_id", null: false
    t.string "mood"
    t.string "energy"
    t.string "training"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_logs_on_dog_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.bigint "dog_id", null: false
    t.bigint "user_id", null: false
    t.string "medication_name"
    t.boolean "completed"
    t.date "start_date"
    t.date "end_date"
    t.text "description"
    t.string "dosage"
    t.string "time_of_day"
    t.integer "number_of_times_per_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_prescriptions_on_dog_id"
    t.index ["user_id"], name: "index_prescriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "mobile_number"
    t.boolean "is_vet"
    t.time "opening_time"
    t.time "closing_time"
    t.date "log_date"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vet_dogs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "dog_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending"
    t.index ["dog_id"], name: "index_vet_dogs_on_dog_id"
    t.index ["user_id"], name: "index_vet_dogs_on_user_id"
  end

  create_table "walks", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.float "pace"
    t.decimal "start_lat", precision: 10, scale: 6
    t.decimal "start_lng", precision: 10, scale: 6
    t.decimal "end_lat", precision: 10, scale: 6
    t.decimal "end_lng", precision: 10, scale: 6
    t.float "distance"
    t.bigint "dog_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.json "path"
    t.index ["dog_id"], name: "index_walks_on_dog_id"
    t.index ["user_id"], name: "index_walks_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chats", "users"
  add_foreign_key "dogs", "users"
  add_foreign_key "logs", "dogs"
  add_foreign_key "messages", "chats"
  add_foreign_key "prescriptions", "dogs"
  add_foreign_key "prescriptions", "users"
  add_foreign_key "vet_dogs", "dogs"
  add_foreign_key "vet_dogs", "users"
  add_foreign_key "walks", "dogs"
  add_foreign_key "walks", "users"
end
