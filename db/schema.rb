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

ActiveRecord::Schema.define(:version => 20110923011021) do

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

  create_table "crew_list_entries", :force => true do |t|
    t.integer  "voyage_id"
    t.integer  "person_id"
    t.string   "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "encounters", :force => true do |t|
    t.integer  "artefact_id"
    t.string   "encounter_type"
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
