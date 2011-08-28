class ActsAsRelatableMigration < ActiveRecord::Migration
  def self.up
    # Relationship table
    create_table :relationships, :force => true do |t|
      t.integer  :relator_id
      t.string   :relator_type
      t.integer  :related_id
      t.string   :related_type
      t.string   :strength
      t.timestamps
    end

    # Map the relationships
    for relation in Relation.all
      if relation.source and relation.target
        puts "creating relation between #{relation.source_type} #{relation.source_id} and #{relation.target_type} #{relation.target_id}"
        relation.relate_endpoints
      else
        puts "destroying relation #{relation.id} because it is missing a target or source"
        relation.destroy
      end
    end

    # Relationship indexes
    add_index :relationships, :related_id
    add_index :relationships, :related_type
    add_index :relationships, :relator_id
    add_index :relationships, :relator_type
    add_index :relationships, :strength    
  end


  def self.down
    drop_table :relationships
  end
end
