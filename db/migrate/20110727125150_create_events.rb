class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.belongs_to :artefact
      t.belongs_to :person
      t.string :display_order
      t.string :event_type
      t.string :direction
      t.string :associated_person
      t.string :associated_institution
      t.datetime :date
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
