class ChangeInventoryListEntryOrderToInteger < ActiveRecord::Migration
  def self.up
    change_column :inventory_list_entries, :list_order, :integer
  end

  def self.down
    change_column :inventory_list_entries, :list_order, :string
  end
end
