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
    raise "Must set ENV['KIWA_OFFLINE_SERVER_PORT']" if ENV['KIWA_OFFLINE_SERVER_PORT'].blank?
    SiteExporter.export("http://localhost:#{ENV['KIWA_OFFLINE_SERVER_PORT']}/pages/offline_index",
      :offline_host => "localhost:#{ENV['KIWA_OFFLINE_SERVER_PORT']}",
      :online_host => 'aofe.maa.cam.ac.uk:3000',
      :output_path => '../exports/full_site',
      :title_page => "/pages/offline_index",
      :zipfile => "../exports/full_site.zip")
  end
end