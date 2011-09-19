class GeocodeLocations < ActiveRecord::Migration
  def up
    Location.destroy_all
    Encounter.find_each(&:geocode_locations)
    Voyage.find_each(&:geocode_locations)
  end

  def down
    Location.destroy_all
  end
end
