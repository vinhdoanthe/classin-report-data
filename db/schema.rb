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

ActiveRecord::Schema.define(version: 2020_11_04_085053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "processed_data", force: :cascade do |t|
    t.integer "class_id", null: false
    t.integer "course_id", null: false
    t.json "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sid"
    t.string "cmd"
    t.datetime "close_time"
    t.datetime "start_time"
    t.string "msg_id"
    t.datetime "action_time"
    t.bigint "source_id"
    t.index ["class_id"], name: "index_processed_data_on_class_id"
    t.index ["course_id"], name: "index_processed_data_on_course_id"
  end

  create_table "raw_data", force: :cascade do |t|
    t.json "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "config_key", null: false
    t.string "config_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
