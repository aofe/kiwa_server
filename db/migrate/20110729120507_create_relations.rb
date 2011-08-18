class CreateRelations < ActiveRecord::Migration
  def self.up
    create_table :relations do |t|
      t.belongs_to :target, :polymorphic => true
      t.belongs_to :source, :polymorphic => true
      t.string :rating
      
      t.timestamps
    end    
  end

  def self.down
    drop_table :relations
  end
end
