class CreateExpeditions < ActiveRecord::Migration
  def self.up
    create_table :expeditions do |t|
      t.string :title
      t.string :commissioned
      t.timestamps
    end
  end

  def self.down
    drop_table :expeditions
  end
end
