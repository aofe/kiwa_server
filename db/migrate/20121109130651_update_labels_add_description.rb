class UpdateLabelsAddDescription < ActiveRecord::Migration
  def change
    add_column :labels, :description, :string, :limit => 255
  end
end
