class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :local_name
      t.float :latitude
      t.float :longitude
      
      t.timestamps
    end
    
    create_table :location_links do |t|
      t.integer :parent_id
      t.integer :child_id
    end    
    
    create_table :location_descendants do |t|
      t.integer :ancestor_id
      t.integer :descendant_id
      t.integer :distance
    end    

  end
end
