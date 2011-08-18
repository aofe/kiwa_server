class CreateInventories < ActiveRecord::Migration
  def self.up
    create_table :inventories do |t|
      t.belongs_to :institution
      t.string :id_tag
      t.string :short_title
      t.string :long_title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :inventories
  end
end
