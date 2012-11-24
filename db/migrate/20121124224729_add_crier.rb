class AddCrier < ActiveRecord::Migration
  def up
    create_table Crier::Notification.table_name, :force => true do |t|
      t.string :scope
      t.text :message

      t.integer :crier_id

      t.string :subject_type
      t.integer :subject_id

      t.string :action

      t.text :metadata

      t.boolean :private, :null => false, :default => false
      t.timestamps
    end

    add_index Crier::Notification.table_name, :scope
    
    create_table Crier::Listening.table_name, :force => true do |t|
      t.belongs_to :notification
      t.belongs_to :user
    end

    add_index Crier::Listening.table_name, :notification_id
    add_index Crier::Listening.table_name, :user_id    
  end

  def down
    drop_table Crier::Notification.table_name
    drop_table Crier::Listening.table_name
  end
end
