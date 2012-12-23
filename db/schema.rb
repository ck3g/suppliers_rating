# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121223095901) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "comments", :force => true do |t|
    t.text     "message"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "services", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "category_id"
  end

  add_index "services", ["category_id"], :name => "index_services_on_category_id"
  add_index "services", ["name"], :name => "index_services_on_name"

  create_table "supplier_services", :force => true do |t|
    t.integer  "supplier_id"
    t.integer  "service_id"
    t.decimal  "price",       :precision => 10, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
  end

  add_index "supplier_services", ["supplier_id", "service_id"], :name => "index_supplier_services_on_supplier_id_and_service_id"

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.decimal  "rating",                                      :default => 0.0
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.string   "contacts"
    t.string   "pay_to"
    t.decimal  "total_amount", :precision => 10, :scale => 2, :default => 0.0
  end

  add_index "suppliers", ["name"], :name => "index_suppliers_on_name"

  create_table "tasks", :force => true do |t|
    t.integer  "supplier_service_id"
    t.string   "title"
    t.text     "description"
    t.decimal  "cost",                :precision => 10, :scale => 2
    t.string   "status",                                             :default => "open"
    t.integer  "rating"
    t.datetime "finished_at"
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
  end

  add_index "tasks", ["status"], :name => "index_tasks_on_status"
  add_index "tasks", ["supplier_service_id"], :name => "index_tasks_on_supplier_service_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
