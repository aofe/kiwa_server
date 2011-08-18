class CreateVoyages < ActiveRecord::Migration
  def self.up
    create_table :voyages do |t|
      t.belongs_to :expedtion
      t.datetime :start_date
      t.datetime :end_date
      t.string :place_departed
      t.string :place_returned
      t.string :ship_name
      t.string :ship_other_name
      t.string :ship_tonnage
      t.string :ship_length
      t.string :ship_beam
      t.string :ship_type
      t.string :ship_cargo
      t.timestamps
    end
  end

  def self.down
    drop_table :voyages
  end
end
