class CreateEncounters < ActiveRecord::Migration
  def self.up
    create_table :encounters do |t|
      t.belongs_to :artefact
      t.string :encounter_type
      t.string :unique_id
      t.string :accession_number
      t.string :part_count
      t.string :name
      t.string :place_of_origin
      t.string :indegenous_name
      t.string :material
      t.text :description
      t.string :dimensions
      t.string :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :artefacts
  end
end
