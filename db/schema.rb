# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_316_205_424) do
  create_table 'medical_recommendations', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'number', null: false
    t.string 'issuer', null: false
    t.string 'state', null: false
    t.date 'expiration_date', null: false
    t.string 'image', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['number'], name: 'index_medical_recommendations_on_number', unique: true
    t.index ['user_id'], name: 'index_medical_recommendations_on_user_id'
  end

  create_table 'state_ids', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'number', null: false
    t.string 'state', null: false
    t.date 'expiration_date', null: false
    t.string 'image', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['number'], name: 'index_state_ids_on_number', unique: true
    t.index ['state'], name: 'index_state_ids_on_state'
    t.index ['user_id'], name: 'index_state_ids_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.date 'date_of_birth', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end
end
