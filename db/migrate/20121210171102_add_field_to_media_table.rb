class AddFieldToMediaTable < ActiveRecord::Migration
  def change
  	add_column :media_items, :source_id, :integer
  end
end
