class CreateDataIndexTables < ActiveRecord::Migration
  def up
  	create_table :_index_artefacts  do |t|
  		t.string :institution
  		t.string :encounters
  		t.string :relations
  	end

  	create_table :_index_crew  do |t|
  		t.integer :voyage_id
  		t.text :crew
  	end

  	create_table :_index_media  do |t|
  		t.integer :attachable_id
  		t.string :attachable_type
  		t.text :media
  	end

  	create_table :_index_notes  do |t|
  		t.string :notable_type
  		t.integer :notable_id
  		t.text :notes
  	end

  	create_table :_index_record_log  do |t|
  		t.integer :log_id
  		t.string :item_type
  		t.integer :item_id
  		t.timestamp :created_at
  	end
  end

  def down
  	drop_table :_index_artefacts
  	drop_table :_index_crew
  	drop_table :_index_media
  	drop_table :_index_notes
  	drop_table :_index_record_log
  end
end
