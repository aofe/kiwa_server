class GeocodeLocations < ActiveRecord::Migration
  def up
    Encounter.find_each(&:geocode_locations)
    Voyage.find_each(&:geocode_locations)
  end

  def down
    Location.destroy_all
  end
end
