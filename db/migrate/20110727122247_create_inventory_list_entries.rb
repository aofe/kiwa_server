class CreateInventoryListEntries < ActiveRecord::Migration
  def self.up
    create_table :inventory_list_entries do |t|
      t.belongs_to :inventory
      t.string :list_order
      t.string :id_tag
      t.string :item_count
      t.text :description
      t.string :page
      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_list_entries
  end
end
