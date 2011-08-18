class CreateMediaItems < ActiveRecord::Migration
  def self.up
    create_table :media_items do |t|
      t.belongs_to :attachable, :polymorphic => true
      t.integer :display_order
      t.string :source_url
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :media_items
  end
end
