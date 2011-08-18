class CreateCrewListEntries < ActiveRecord::Migration
  def self.up
    create_table :crew_list_entries do |t|
      t.belongs_to :voyage
      t.belongs_to :person
      t.string :rank
      t.timestamps
    end
  end

  def self.down
    drop_table :crew_list_entries
  end
end
