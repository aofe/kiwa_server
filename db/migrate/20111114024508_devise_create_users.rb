class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.trackable
      t.string :username

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :users, :username,             :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
    
    User.create! do |user|
      user.username = 'carl'
      user.password = 'kiwa1234'
      user.password_confirmation = 'kiwa1234'
      user.email = 'cdh30@cam.ac.uk'
    end
  end

  def self.down
    drop_table :users
  end
end
