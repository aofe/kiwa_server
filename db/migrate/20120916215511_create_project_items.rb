class CreateProjectItems < ActiveRecord::Migration
  def change
    create_table :project_items do |t|
      t.belongs_to :item, :polymorphic => true
      t.belongs_to :project
      t.text :note

      t.timestamps
    end
  end
end
