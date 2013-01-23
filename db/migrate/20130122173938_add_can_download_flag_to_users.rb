class AddCanDownloadFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :can_download, :boolean, :null => false, :default => false
  end
end
