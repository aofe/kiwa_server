class AddKiwaDataAdminTables < ActiveRecord::Migration
  def up
  	create_table :_log_access  do |t|
  		t.string :access_type
  		t.integer :user_id
  		t.text :response
  		t.timestamp :created_at
  	end

  	create_table :_log_edit  do |t|
  		t.integer :record_log_id
  		t.string :field
  		t.string :event
  		t.integer :place
  		t.integer :edit
  		t.timestamp :created_at
  	end

  	create_table :_log_record  do |t|
  		t.string :record_type
  		t.integer :record_id
  		t.string :event
  		t.integer :user_id
  		t.timestamp :created_at
  	end

  	create_table :_log_schedule  do |t|
  		t.text :log
  		t.timestamp :created_at
  	end

  	create_table :_comments  do |t|
  		t.string :table_name
  		t.integer :row_id
  		t.string :field_name
  		t.text :comment
  	end

  	create_table :_images  do |t|
  		t.string :format
		t.date :date_made
		t.string :location
		t.string :photographer
		t.integer :width
		t.integer :height
		t.integer :l_width
		t.integer :l_height
		t.integer :m_width
		t.integer :m_height
		t.integer :s_width
		t.integer :s_height
		t.integer :t_width
		t.integer :t_height
		t.timestamp :created_at
	end

	create_table :_users  do |t|
  		t.string :username
		t.string :encrypted_password
		t.string :name
		t.string :email
		t.integer :active
		t.integer :administrator
		t.integer :kiwatools
		t.timestamp :current_sign_in_at
		t.timestamp :last_sign_in_at
		t.timestamp :created_at
		t.timestamp :updated_at
	end
  end

  def down
  	drop_table :_log_access
  	drop_table :_log_edit
  	drop_table :_log_record
  	drop_table :_log_schedule
  	drop_table :_comments
  	drop_table :_images
  	drop_table :_users
  end
end