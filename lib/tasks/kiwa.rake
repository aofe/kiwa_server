namespace :kiwa do
  task :update_relationships => :environment do
    puts "Updating relationships from relations table"
    Relation.find_each(&:relate_endpoints)
  end  

  task :geocode_locations => :environment do
    puts "Destroying Locations"
    Location.destroy_all
    puts "Geocoding Encounters"
    Encounter.find_each(&:geocode_locations)
    puts "Geocoding Voyages"
    Voyage.find_each(&:geocode_locations)
  end

  task :create_user_invite, [:email, :username] => :environment do |t, args|
    User.invite!(:email => args.email, :name => args.username)
  end 
end