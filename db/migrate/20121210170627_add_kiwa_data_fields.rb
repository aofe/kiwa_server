class AddKiwaDataFields < ActiveRecord::Migration
  def change
  	add_column :events, :place, :string
  	add_column :people, :place, :string
  	add_column :cards, :description, :text
  end
end
