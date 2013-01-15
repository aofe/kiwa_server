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


  task :full_site_export => :environment do
    SiteExporter.export("http://localhost:3000/pages/offline_index", :online_host => 'aofe.maa.cam.ac.uk:3000')
  end

  task :project_export => :environment do
    SiteExporter.export("http://localhost:3000/collections/5", :full_size_photos => true, :recursion_depth => 1, :output_path => '../project5', :online_host => 'aofe.maa.cam.ac.uk:3000')
  end
end