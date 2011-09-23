class FixSpellingOfIndigenousOnEncounter < ActiveRecord::Migration
  def change
    rename_column :encounters, :indegenous_name, :indigenous_name
  end
end
