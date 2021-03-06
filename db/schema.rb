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

ActiveRecord::Schema.define(version: 20161206223812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.integer  "group_id"
    t.integer  "question_id"
    t.text     "answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "body"
    t.boolean  "public"
    t.text     "summary"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.boolean  "public"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "fg_bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "booking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "focus_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "start"
    t.integer  "slots"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forms", force: :cascade do |t|
    t.string   "title"
    t.integer  "group_id"
    t.string   "description"
    t.text     "body"
    t.date     "date_required"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "group_change_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer  "level"
    t.string   "name"
    t.string   "contact"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "i_questions", force: :cascade do |t|
    t.integer  "i_survey_id"
    t.integer  "input_type"
    t.string   "description"
    t.integer  "grouping_value"
    t.boolean  "enabled"
    t.string   "comment"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "order"
  end

  create_table "i_surveys", force: :cascade do |t|
    t.string   "description"
    t.integer  "group_id"
    t.integer  "form_id"
    t.string   "coding_explanation"
    t.boolean  "enabled"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "title"
  end

  create_table "industries", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "address"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "stem_foci"
    t.text     "description"
    t.text     "blurb"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "show_info"
  end

  create_table "industry_presentations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "industry_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "presentation_file_name"
    t.string   "presentation_content_type"
    t.integer  "presentation_file_size"
    t.datetime "presentation_updated_at"
    t.string   "script_file_name"
    t.string   "script_content_type"
    t.integer  "script_file_size"
    t.datetime "script_updated_at"
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "name"
    t.date     "date"
    t.text     "description"
    t.boolean  "final"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "minutes_file_name"
    t.string   "minutes_content_type"
    t.integer  "minutes_file_size"
    t.datetime "minutes_updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "author"
    t.boolean  "public"
    t.integer  "group_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_teams", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.integer  "team"
    t.boolean  "enabled"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "research_scientists", force: :cascade do |t|
    t.integer  "student_group_id"
    t.integer  "user_id"
    t.string   "public_email"
    t.string   "public_phone"
    t.text     "public_bio"
    t.boolean  "enabled"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "rsvps", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "role"
    t.string   "school"
    t.string   "year_level"
    t.string   "for_full_name"
    t.string   "for_email"
    t.boolean  "attending_too"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "attended"
    t.boolean  "interested"
  end

  create_table "signatures", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "form_id"
    t.binary   "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stc2016s", force: :cascade do |t|
    t.string   "name"
    t.integer  "degreeyear"
    t.string   "email"
    t.boolean  "plusone"
    t.string   "plusone_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "student_blogs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.boolean  "finished"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_groups", force: :cascade do |t|
    t.boolean  "confirmed"
    t.boolean  "finalised"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.date     "when"
    t.boolean  "visible"
    t.boolean  "completed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "unit_presentations", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "presentation_file_name"
    t.string   "presentation_content_type"
    t.integer  "presentation_file_size"
    t.datetime "presentation_updated_at"
    t.string   "notes_file_name"
    t.string   "notes_content_type"
    t.integer  "notes_file_size"
    t.datetime "notes_updated_at"
    t.string   "unit_overview_file_name"
    t.string   "unit_overview_content_type"
    t.integer  "unit_overview_file_size"
    t.datetime "unit_overview_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "administrator"
    t.integer  "group_id"
    t.string   "gender"
    t.integer  "age"
    t.string   "degree"
    t.string   "major"
    t.integer  "industry_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "student_group_id"
    t.integer  "focus_group_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_and_groups", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.index ["group_id"], name: "index_users_and_groups_on_group_id", using: :btree
    t.index ["user_id"], name: "index_users_and_groups_on_user_id", using: :btree
  end

end
