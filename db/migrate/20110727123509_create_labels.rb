class CreateLabels < ActiveRecord::Migration
  def self.up
    create_table :labels do |t|
      t.belongs_to :encounter
      t.string :id_tag
      t.string :inscription
      t.string :attachment_method
      t.string :attachment_location
      t.timestamps
    end
  end

  def self.down
    drop_table :labels
  end
end
