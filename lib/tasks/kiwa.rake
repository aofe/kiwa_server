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
    require 'pathname'
    require 'digest'
    require 'nokogiri'

    # Load helpers necessary for generating restful paths (SOURCE: http://stackoverflow.com/questions/4262044/rails-3-how-to-render-erb-template-in-rake-task)
    include Rails.application.routes.url_helpers # brings ActionDispatch::Routing::UrlFor
    include ActionView::Helpers::TagHelper

    start = Time.now
    default_url_options[:host] = 'localhost:3000'
    offline_mode_params = {:offline_key => ENV['KIWA_OFFLINE_KEY']}
    output_dir = "../offline"
    offline_page_path = "#{output_dir}/pages"
    offline_image_path = "#{output_dir}/images"
    image_manifest_path = "#{offline_image_path}/image_manifest.txt"

    # -nH to skip creation of host directories, e.g. offline/localhost:3000/ or offline/maa.xyz.com/
    # -r -l inf to set infinite recursion
    # -k to convert links for local viewing
    # -E to adjust all extensions so they are HTML files
    # -P to set the output path
    `wget #{pages_url({:controller => :pages, :action => :offline_index}.merge(offline_mode_params))} -nH -r -l inf -k -E -P #{offline_page_path}`

    # Remove query params used to put the page into offline mode
    Dir.glob("#{offline_page_path}/**/*#{offline_mode_params.to_query}*.html").each do |file|
      File.rename(file, file.gsub('?' + offline_mode_params.to_query, ''))
    end

    # Convert all remote image references to local ones, and download the appropriate images
    images_to_fetch = []
    Dir.glob("#{offline_page_path}/**/*.html").each do |file_name|
      print "Changing image links in #{file_name}..."

      doc = Nokogiri::HTML(open file_name)
      image_count = doc.css('img').count
      print "#{image_count} images found..."

      if image_count > 0
        puts ""
        doc.css('img').each do |img|
          # Generate a path that points from the offline page to the offline image
          image_path = "#{offline_image_path}/#{Digest::SHA2.hexdigest(img['src'])}.jpg"
          images_to_fetch << img['src']
          relative_path_from_page_to_image = Pathname.new(image_path).relative_path_from(Pathname.new(File.dirname(file_name))).to_s          
          img.set_attribute('src', relative_path_from_page_to_image)

          puts " - " + Pathname.new(image_path).to_s + " => " + relative_path_from_page_to_image
        end

        File.open(file_name, "w") {|file| file.write doc.to_html}
      end

      puts 'done'
    end
    images_to_fetch.uniq!

    puts "Fetching #{images_to_fetch.count} images"
    FileUtils.mkdir_p(File.dirname image_manifest_path)
    File.open(image_manifest_path, "w") do |file|
      images_to_fetch.reject{|url| url =~ /maps.google/}.each do |url|
        file.write "#{url}\n"
      end
    end

    # # Fetch the images, remember to include a referrer because the server won't give the images out to just anyone
    puts `wget -i #{image_manifest_path} -H -p -P #{offline_image_path} --referer=http://localhost:3000/aofe_encounters/`

    # Rename all images to their hashed name (all files end in html)
    images_to_fetch.each do |url|
      source_name = "#{offline_image_path}/#{url.gsub('http://','')}index.html"
      dest_name = "#{offline_image_path}/#{Digest::SHA2.hexdigest(url)}.jpg"
      if File.exists?(source_name)
        puts "Moving #{source_name} to #{dest_name}"
        FileUtils.mv(source_name, dest_name)
      else
        puts "Couldn't find #{source_name}"
      end
    end

    # Remove the image_manifest
    puts "Deleting Image Manifest"
    File.delete(image_manifest_path)

    # Remove all the empty directories from the image hierarchy
    puts "Removing temporary image directories"
    Dir.glob("#{offline_image_path}/*").sort_by{|dir| -dir.length }.each do |directory|
      if File.directory?(directory)
        puts " - #{directory}"
        FileUtils.rm_rf directory
      end
    end

    puts "Exported in #{Time.now - start} seconds"
  end
end