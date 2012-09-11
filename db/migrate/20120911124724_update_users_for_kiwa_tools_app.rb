class UpdateUsersForKiwaToolsApp < ActiveRecord::Migration
  def change
    add_column :users, :invitation_count, :integer
    add_column :users, :active, :integer
  end
end