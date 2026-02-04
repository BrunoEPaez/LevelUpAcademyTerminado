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

ActiveRecord::Schema[8.1].define(version: 2026_02_04_192940) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "applications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["job_id"], name: "index_applications_on_job_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "free"
    t.string "instructor"
    t.string "language"
    t.bigint "path_id", null: false
    t.string "thumbnail_url"
    t.string "title"
    t.datetime "updated_at", null: false
    t.string "youtube_id"
    t.index ["path_id"], name: "index_courses_on_path_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["job_id"], name: "index_favorites_on_job_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "company"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "instructor"
    t.string "job_type"
    t.string "location"
    t.string "modality"
    t.string "salary"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.text "content"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "position"
    t.string "title"
    t.datetime "updated_at", null: false
    t.string "youtube_id"
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "paths", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "language"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "progresses", force: :cascade do |t|
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.bigint "lesson_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["lesson_id"], name: "index_progresses_on_lesson_id"
    t.index ["user_id"], name: "index_progresses_on_user_id"
  end

  create_table "user_courses", force: :cascade do |t|
    t.boolean "completed"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.boolean "favorite"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_user_courses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "address"
    t.text "avatar_base64"
    t.string "avatar_url"
    t.text "bio"
    t.date "birthdate"
    t.string "city"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "github_url"
    t.string "linkedin_url"
    t.string "name"
    t.string "phone"
    t.string "portfolio_url"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "applications", "jobs"
  add_foreign_key "applications", "users"
  add_foreign_key "courses", "paths"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "favorites", "jobs"
  add_foreign_key "favorites", "users"
  add_foreign_key "jobs", "users"
  add_foreign_key "lessons", "courses"
  add_foreign_key "progresses", "lessons"
  add_foreign_key "progresses", "users"
  add_foreign_key "user_courses", "users"
end
