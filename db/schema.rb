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

ActiveRecord::Schema.define(version: 20180320093127) do

  create_table "customer_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "password_digest", null: false
    t.string "username"
    t.string "mobile"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "student_id"
    t.bigint "teacher_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_lessons_on_student_id"
    t.index ["teacher_id"], name: "index_lessons_on_teacher_id"
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "student_id"
    t.string "number", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "payment_method", null: false
    t.integer "state", default: 0
    t.string "payment_transacation_id"
    t.string "response_code"
    t.text "avs_response"
    t.boolean "notified", default: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_payments_on_number"
    t.index ["student_id"], name: "index_payments_on_student_id"
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.decimal "price", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "mobile", null: false
    t.string "email"
    t.string "wechat"
    t.integer "gender", limit: 1, default: -1
    t.string "wx_openid"
    t.string "wx_unionid"
    t.integer "number_of_lessons"
    t.datetime "expired_at"
    t.datetime "locked_at"
    t.text "extras"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "student_id"
    t.bigint "product_id"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_students_products_on_product_id"
    t.index ["student_id"], name: "index_students_products_on_student_id"
  end

  create_table "teachers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username"
    t.string "mobile"
    t.string "email"
    t.string "wechat"
    t.text "extras"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
