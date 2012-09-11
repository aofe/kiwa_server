class UpdateUsersForDeviseInvitable < ActiveRecord::Migration
  def change
    add_column :users, :invitation_token, :string, :limit => 60
    add_column :users, :invitation_sent_at, :datetime 
    add_column :users, :invitation_accepted_at, :datetime
    add_column :users, :invitation_limit, :string
    add_column :users, :invited_by_id, :integer
    add_column :users, :invited_by_type, :string
  end
  change_column :users, :encrypted_password, :string, :null => true
end