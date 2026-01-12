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

ActiveRecord::Schema[7.0].define(version: 2026_01_07_030250) do
  create_table "ai_conversations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "teacher_id", null: false
    t.bigint "context_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context_class_id"], name: "index_ai_conversations_on_context_class_id"
    t.index ["teacher_id"], name: "index_ai_conversations_on_teacher_id"
  end

  create_table "ai_messages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "ai_conversation_id", null: false
    t.string "role", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ai_conversation_id"], name: "index_ai_messages_on_ai_conversation_id"
    t.index ["role"], name: "index_ai_messages_on_role"
  end

  create_table "assignment_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.text "file_url", null: false
    t.string "file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_assignment_attachments_on_assignment_id"
  end

  create_table "assignments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "class_id", null: false
    t.string "title", limit: 200, null: false
    t.text "content"
    t.datetime "due_date"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["class_id"], name: "index_assignments_on_class_id"
    t.index ["due_date"], name: "index_assignments_on_due_date"
  end

  create_table "attendance_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "attendance_session_id", null: false
    t.bigint "student_id", null: false
    t.string "status", null: false
    t.string "note"
    t.decimal "score_in_class", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendance_session_id", "student_id"], name: "index_attendance_records_on_attendance_session_id_and_student_id", unique: true
    t.index ["attendance_session_id"], name: "index_attendance_records_on_attendance_session_id"
    t.index ["status"], name: "index_attendance_records_on_status"
    t.index ["student_id"], name: "index_attendance_records_on_student_id"
  end

  create_table "attendance_sessions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "class_id", null: false
    t.datetime "date", null: false
    t.text "teacher_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["class_id", "date"], name: "index_attendance_sessions_on_class_id_and_date", unique: true
    t.index ["class_id"], name: "index_attendance_sessions_on_class_id"
  end

  create_table "classes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "subject", null: false
    t.string "grade_level"
    t.bigint "teacher_id", null: false
    t.json "schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.decimal "fee_per_session", precision: 15, scale: 2
    t.string "status", default: "active"
    t.text "cover_image"
    t.index ["name"], name: "index_classes_on_name"
    t.index ["status"], name: "index_classes_on_status"
    t.index ["teacher_id"], name: "index_classes_on_teacher_id"
  end

  create_table "enrollments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "class_id", null: false
    t.bigint "student_id", null: false
    t.string "status", default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "tuition_debt", precision: 15, scale: 2, default: "0.0"
    t.integer "sessions_attended", default: 0
    t.timestamp "joined_at"
    t.index ["class_id", "student_id"], name: "index_enrollments_on_class_id_and_student_id", unique: true
    t.index ["class_id"], name: "index_enrollments_on_class_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "packages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.decimal "price", precision: 15, scale: 2, null: false
    t.integer "duration_days", null: false
    t.json "features"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_active"], name: "index_packages_on_is_active"
    t.index ["name"], name: "index_packages_on_name", unique: true
  end

  create_table "parent_student_links", primary_key: ["parent_id", "student_id"], charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "parent_id", null: false
    t.string "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_parent_student_links_on_parent_id"
    t.index ["student_id"], name: "index_parent_student_links_on_student_id"
  end

  create_table "students", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "full_name", null: false
    t.date "dob"
    t.string "parent_name"
    t.string "parent_phone"
    t.string "school"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_id"
    t.string "student_code"
    t.decimal "wallet_balance", precision: 15, scale: 2, default: "0.0"
    t.index ["student_code"], name: "index_students_on_student_code", unique: true
    t.index ["user_id"], name: "index_students_on_user_id", unique: true
  end

  create_table "submissions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.bigint "student_id", null: false
    t.text "content"
    t.text "file_url"
    t.datetime "submitted_at", null: false
    t.string "status", default: "submitted"
    t.decimal "score", precision: 5, scale: 2
    t.text "teacher_feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id", "student_id"], name: "index_submissions_on_assignment_id_and_student_id", unique: true
    t.index ["assignment_id"], name: "index_submissions_on_assignment_id"
    t.index ["status"], name: "index_submissions_on_status"
    t.index ["student_id"], name: "index_submissions_on_student_id"
  end

  create_table "teachers", primary_key: "user_id", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "bio"
    t.bigint "package_id"
    t.datetime "package_expiry"
    t.decimal "rating_avg", precision: 3, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_teachers_on_package_id"
  end

  create_table "transactions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "class_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.date "payment_date", null: false
    t.string "status", default: "Completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "method"
    t.string "description"
    t.index ["class_id"], name: "index_transactions_on_class_id"
    t.index ["created_at"], name: "index_transactions_on_created_at"
    t.index ["payment_date"], name: "index_transactions_on_payment_date"
    t.index ["user_id", "class_id"], name: "index_transactions_on_user_id_and_class_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "full_name", null: false
    t.string "role", default: "teacher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "otp_code"
    t.datetime "otp_expires_at"
    t.boolean "otp_verified", default: false
    t.boolean "is_active", default: false
    t.string "user_id"
    t.string "display_name", limit: 100, default: "User"
    t.text "photo_url"
    t.string "phone_number", limit: 20
    t.string "google_uid"
    t.string "provider"
    t.string "access_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["otp_code"], name: "index_users_on_otp_code"
    t.index ["user_id"], name: "index_users_on_user_id", unique: true
  end

  add_foreign_key "ai_conversations", "classes", column: "context_class_id"
  add_foreign_key "ai_conversations", "teachers", primary_key: "user_id"
  add_foreign_key "ai_messages", "ai_conversations"
  add_foreign_key "assignment_attachments", "assignments"
  add_foreign_key "assignments", "classes"
  add_foreign_key "attendance_records", "attendance_sessions"
  add_foreign_key "attendance_records", "students"
  add_foreign_key "attendance_sessions", "classes"
  add_foreign_key "classes", "users", column: "teacher_id"
  add_foreign_key "enrollments", "classes"
  add_foreign_key "enrollments", "students"
  add_foreign_key "parent_student_links", "users", column: "parent_id", primary_key: "user_id"
  add_foreign_key "parent_student_links", "users", column: "student_id", primary_key: "user_id"
  add_foreign_key "students", "users", primary_key: "user_id"
  add_foreign_key "submissions", "assignments"
  add_foreign_key "submissions", "students"
  add_foreign_key "teachers", "packages"
  add_foreign_key "teachers", "users", primary_key: "user_id"
  add_foreign_key "transactions", "classes"
  add_foreign_key "transactions", "users"
end
