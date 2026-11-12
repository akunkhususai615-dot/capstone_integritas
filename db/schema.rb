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

ActiveRecord::Schema[8.1].define(version: 2026_11_12_091412) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "title", null: false
    t.text "description"
    t.date "deadline", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_assignments_on_course_id"
    t.index ["deadline"], name: "index_assignments_on_deadline"
    t.index ["title"], name: "index_assignments_on_title"
  end

  create_table "courses", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_courses_on_code", unique: true
  end

  create_table "students", force: :cascade do |t|
    t.string "nim", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["nim"], name: "index_students_on_nim", unique: true
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "assignment_id", null: false
    t.decimal "score", precision: 5, scale: 2
    t.string "status", default: "pending", null: false
    t.datetime "submitted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_submissions_on_assignment_id"
    t.index ["student_id", "assignment_id"], name: "index_submissions_on_student_and_assignment", unique: true
    t.index ["student_id"], name: "index_submissions_on_student_id"
    t.check_constraint "score IS NULL OR score >= 0::numeric AND score <= 100::numeric", name: "check_submission_score_range"
  end

  add_foreign_key "assignments", "courses"
  add_foreign_key "submissions", "assignments"
  add_foreign_key "submissions", "students"
end
