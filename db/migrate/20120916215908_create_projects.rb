class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.belongs_to :user
      t.string :name
      t.text :description
      t.boolean :public 
      t.timestamps
    end
  end
end
