class SchemaUpdate < ActiveRecord::Migration
  def self.up
  
	  create_table :notes do |t|
		  t.belongs_to :notable, :polymorphic => true
		  t.integer :note_order
		  t.string :note_type
		  t.text :note_text
		  t.timestamps
	  end

	  create_table :person_expeditions do |t|
		  t.belongs_to :persons
		  t.belongs_to :expeditions
		  t.timestamps
	  end

	  remove_column :inventories, :institution_id
	  remove_column :inventories, :id_tag
	  add_column :inventories, :source_reference, :string
	  remove_column :labels, :encounter_id
	  add_column :labels, :institution_id, :integer
	  add_column :labels, :dimensions, :string
	  change_column :labels, :inscription, :text
	  add_column :cards, :institution_id, :integer
	  change_column :cards, :inscription, :text
	  rename_column :people, :character, :character_reference
	  rename_column :events, :date, :event_date
 
 end

  def self.down
	raise "Unreversable migration"  
  end
end