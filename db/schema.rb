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

ActiveRecord::Schema.define(:version => 20120916215908) do

  create_table "archives", :force => true do |t|
    t.integer  "institution_id"
    t.string   "id_num"
    t.string   "archive_type"
    t.string   "sub_type"
    t.string   "author"
    t.text     "title_long"
    t.string   "title_short"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "start_year"
    t.integer  "start_month"
    t.integer  "start_day"
    t.integer  "end_year"
    t.integer  "end_month"
    t.integer  "end_day"
  end

  create_table "artefacts", :force => true do |t|
    t.integer  "institution_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", :force => true do |t|
    t.integer  "institution_id", :null => false
    t.string   "id_tag"
    t.text     "inscription"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "crew_list_entries", :force => true do |t|
    t.integer  "voyage_id"
    t.integer  "person_id"
    t.string   "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "encounters", :force => true do |t|
    t.integer  "artefact_id"
    t.string   "type"
    t.string   "unique_id"
    t.string   "accession_number"
    t.string   "part_count"
    t.string   "name"
    t.string   "place_of_origin"
    t.string   "indigenous_name"
    t.string   "material"
    t.text     "description"
    t.string   "dimensions"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "artefact_id"
    t.integer  "person_id"
    t.string   "display_order"
    t.string   "event_type"
    t.string   "direction"
    t.string   "associated_person"
    t.string   "associated_institution"
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expeditions", :force => true do |t|
    t.string   "title"
    t.string   "commissioned"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "institutions", :force => true do |t|
    t.string   "long_name"
    t.string   "short_name"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventories", :force => true do |t|
    t.string   "short_title"
    t.string   "long_title"
    t.text     "description"
    t.string   "source_reference", :limit => 25, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_list_entries", :force => true do |t|
    t.integer  "inventory_id"
    t.integer  "list_order"
    t.string   "id_tag"
    t.string   "item_count"
    t.text     "description"
    t.string   "page"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labels", :force => true do |t|
    t.integer  "institution_id",      :null => false
    t.string   "id_tag"
    t.text     "inscription"
    t.string   "dimensions"
    t.string   "attachment_method"
    t.string   "attachment_location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_descendants", :force => true do |t|
    t.integer "ancestor_id"
    t.integer "descendant_id"
    t.integer "distance"
  end

  create_table "location_links", :force => true do |t|
    t.integer "parent_id"
    t.integer "child_id"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "local_name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_items", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.integer  "display_order"
    t.string   "source_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_scaleable"
  end

  create_table "notes", :force => true do |t|
    t.string   "notable_type"
    t.integer  "notable_id"
    t.integer  "note_order"
    t.string   "note_type"
    t.text     "note_text",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "other_name"
    t.integer  "birth_year"
    t.integer  "birth_month"
    t.integer  "birth_day"
    t.integer  "death_year"
    t.integer  "death_month"
    t.integer  "death_day"
    t.text     "background"
    t.text     "education"
    t.text     "character_reference"
    t.text     "career"
    t.text     "network"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_expeditions", :force => true do |t|
    t.integer  "person_id"
    t.integer  "expedition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_items", :force => true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "project_id"
    t.text     "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "public"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "reference_digital", :force => true do |t|
    t.string   "format"
    t.integer  "institution_id"
    t.string   "host_name"
    t.string   "author_name"
    t.text     "title"
    t.boolean  "online_status"
    t.string   "url"
    t.text     "copyright"
    t.text     "research_notes"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "source_year"
    t.integer  "source_month"
    t.integer  "source_day"
  end

  create_table "reference_text", :force => true do |t|
    t.string   "source_type"
    t.string   "author_name"
    t.string   "author_initial"
    t.text     "title"
    t.string   "city"
    t.string   "publisher"
    t.string   "book_editor"
    t.string   "book_title"
    t.string   "journal_title"
    t.string   "volume"
    t.string   "number"
    t.string   "pages"
    t.string   "first_edition"
    t.string   "other_edition"
    t.string   "institution"
    t.string   "department"
    t.string   "qualification"
    t.text     "notes"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "source_year"
    t.integer  "source_month"
    t.integer  "source_day"
  end

  create_table "relations", :force => true do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "relator_id"
    t.string   "relator_type"
    t.integer  "related_id"
    t.string   "related_type"
    t.string   "strength"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["related_id"], :name => "index_relationships_on_related_id"
  add_index "relationships", ["related_type"], :name => "index_relationships_on_related_type"
  add_index "relationships", ["relator_id"], :name => "index_relationships_on_relator_id"
  add_index "relationships", ["relator_type"], :name => "index_relationships_on_relator_type"
  add_index "relationships", ["strength"], :name => "index_relationships_on_strength"

  create_table "researchers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "remember_created_at"
    t.string   "name"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.string   "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitation_count"
    t.integer  "active"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "voyages", :force => true do |t|
    t.integer  "expedition_id"
    t.string   "ship_name"
    t.string   "ship_other_name"
    t.integer  "start_year"
    t.integer  "start_month"
    t.integer  "start_day"
    t.integer  "end_year"
    t.integer  "end_month"
    t.integer  "end_day"
    t.string   "place_departed"
    t.string   "place_returned"
    t.string   "ship_tonnage"
    t.string   "ship_length"
    t.string   "ship_beam"
    t.string   "ship_type"
    t.string   "ship_cargo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
