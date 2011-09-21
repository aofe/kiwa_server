class GeocodeLocations < ActiveRecord::Migration
  def up
    Rake::Task['kiwa:geocode_locations'].invoke
  end

  def down
  end
end
