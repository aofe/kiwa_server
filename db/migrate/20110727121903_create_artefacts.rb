class CreateArtefacts < ActiveRecord::Migration
  def self.up
    create_table :artefacts do |t|
      t.belongs_to :institution
      t.timestamps
    end
  end

  def self.down
    drop_table :artefacts
  end
end
