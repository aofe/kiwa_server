class AddDataSourceFieldToEncounterSchema < ActiveRecord::Migration
  def change
  	add_column :encounters, :auto_generated, :integer
  end
end
