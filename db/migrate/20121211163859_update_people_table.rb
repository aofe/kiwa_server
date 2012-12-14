class UpdatePeopleTable < ActiveRecord::Migration
  def change
  	rename_column :people, :place, :place_origin
  	add_column :people, :place_death, :string
  end
end
