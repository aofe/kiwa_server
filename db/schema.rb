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

ActiveRecord::Schema.define(:version => 20110729120507) do

  create_table "artefacts", :force => true do |t|
    t.integer  "institution_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", :force => true do |t|
    t.string   "id_tag"
    t.string   "inscription"
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
    t.string   "indegenous_name"
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
    t.datetime "date"
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
    t.integer  "institution_id"
    t.string   "id_tag"
    t.string   "short_title"
    t.string   "long_title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_list_entries", :force => true do |t|
    t.integer  "inventory_id"
    t.string   "list_order"
    t.string   "id_tag"
    t.string   "item_count"
    t.text     "description"
    t.string   "page"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labels", :force => true do |t|
    t.integer  "encounter_id"
    t.string   "id_tag"
    t.string   "inscription"
    t.string   "attachment_method"
    t.string   "attachment_location"
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

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "other_name"
    t.datetime "birth_date"
    t.datetime "death_date"
    t.text     "background"
    t.text     "education"
    t.text     "character"
    t.text     "career"
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

  create_table "researchers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "voyages", :force => true do |t|
    t.integer  "expedtion_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "place_departed"
    t.string   "place_returned"
    t.string   "ship_name"
    t.string   "ship_other_name"
    t.string   "ship_tonnage"
    t.string   "ship_length"
    t.string   "ship_beam"
    t.string   "ship_type"
    t.string   "ship_cargo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
