class CreateVoyagesDataIndexTable < ActiveRecord::Migration
  def up
  	create_table :_index_voyages  do |t|
		t.integer :expedition_id
		t.string :commissioned
		t.string :ship_name
		t.string :ship_other_name
		t.timestamp :start_date
		t.timestamp :end_date
		t.string :place_departed
		t.string :place_returned
		t.string :ship_tonnage
		t.string :ship_length
		t.string :ship_beam
		t.string :ship_type
		t.string :ship_cargo
		t.timestamp :created_at
		t.timestamp :updated_at
		t.text :people
		t.text :related_people
	end
  end

  def down
  	drop_table :_index_voyages
  end
end
