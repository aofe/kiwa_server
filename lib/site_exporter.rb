module SiteExporter
  require 'pathname'
  require 'digest'
  require 'nokogiri'
  require 'zip/zip'

  # Load helpers necessary for generating restful paths (SOURCE: http://stackoverflow.com/questions/4262044/rails-3-how-to-render-erb-template-in-rake-task)
  include Rails.application.routes.url_helpers # brings ActionDispatch::Routing::UrlFor
  include ActionView::Helpers::TagHelper

  # Returns the path to the local version of a remote image
  # Optionally pass a path to generate a relative path from the path to the local image
  def self.image_cache_path(images_path, remote_image_url, relative_to = nil)
    path = Pathname.new("#{images_path}/#{Digest::SHA2.hexdigest(remote_image_url)}.jpg")
    if relative_to
      path.relative_path_from(Pathname.new(File.dirname(relative_to))).to_s
    else
      path.real_path.to_s
    end
  end

  def self.squeeze_path(path)
    path.squeeze!('/')
    return path
  end

  def self.export(start_url, options = {})
    start = Time.now

    # SETUP

    options.reverse_merge! :output_path => "../exports"
    options.reverse_merge! :recursion_depth => 'inf',
                           :full_size_photos => false, # Don't download full sized photos 
                           :offline_host => 'localhost:3001', # Specified so we can change all links to this host so they point at the online host
                           :online_host => 'www.mywebsite.com', # Location of the server as viewed by a user
                           :page_path => "#{options[:output_path]}/pages",
                           :image_path => "#{options[:output_path]}/images"

  # Remove any double slashes in the paths
    squeeze_path(options[:output_path])
    squeeze_path(options[:page_path])
    squeeze_path(options[:image_path])
  
    Rails.application.routes.default_url_options[:host] ||= options[:offline_host] # If we're running this as a rake task there is no server, therefore we need to set the host manually so we can create urls
    image_manifest_path = "#{options[:image_path]}/image_manifest.txt"
    images_to_fetch = [] # A list of the images used on html pages

    # EXPORT 
    
    # Delete the output directory if it already exists so we can start over
    if options[:output_path]
      puts "Clearing existing files at #{options[:output_path]}"
      FileUtils.rm_rf options[:output_path]
    end

    if options[:zipfile]
      puts "Clearing old zipfile at #{options[:zipfile]}"
      FileUtils.rm_rf options[:zipfile]
    end

    # -nH to skip creation of host directories, e.g. offline/localhost:3000/ or offline/maa.xyz.com/
    # -r -l inf to set infinite recursion
    # -k to convert links for local viewing
    # -E to adjust all extensions so they are HTML files
    # -e to ignore the robots file because we are spidering the site as a user, not as a robot
    # -P to set the output path
    puts "Starting export at #{start_url}"
    `wget "#{start_url}" -nH -k -E -P #{options[:page_path]} -e robots=off -r -l #{options[:recursion_depth]}`

    Dir.glob("#{options[:page_path]}/**/*.html").each do |file_name|
      doc = Nokogiri::HTML(open file_name)
      doc_modified = false

      # Convert all image references to local ones, and download the appropriate images
      images = doc.css('img')
      if images.count > 0
        print "Changing image links in #{file_name}..."
        puts "#{images.count} images found..."

        images.each do |img|
          print " - #{img['src']} => "
          images_to_fetch << img['src']
          img.set_attribute('src', image_cache_path(options[:image_path], img['src'], file_name))
          puts img['src']
        end
        doc_modified = true
      end

      # Download large full size photos and convert all image references to local ones
      photos = doc.css('a.media_thumbnail[data-preview]')
      if photos.count > 0
        print "Changing full size photos links in #{file_name}..."
        puts "#{photos.count} photos found..."

        
        
        if options[:full_size_photos]
          # Adjust the links so they point to the cached full size photo
          photos.each do |link|
            print " - #{link['href']} => "
            images_to_fetch << link['href']
            link.set_attribute('href', image_cache_path(options[:image_path], link['href'], file_name))
            link.remove_attribute('data-preview') # Since we're offline, there's no need for a lowres preview image for the zoomer
            puts link['href']
          end
        else
          # Remove the attributes that link to the full size photo
          photos.each do |link|
            puts " - Unlinking #{link['href']}"
            link.remove_attribute('href')
            link.remove_attribute('data-preview') # Since we're offline, there's no need for a lowres preview image for the zoomer
          end          
        end
        doc_modified = true
      end

      # Convert all remote links to point at the online host instead of the localhost
      if options[:offline_host] != options[:online_host]
        print "Redirecting remote links in #{file_name}..."
        remote_links = doc.css("a[href^='http://#{options[:offline_host]}']")
        puts "#{remote_links.count} remote_links found..."

        remote_links.each do |link|
          print " - #{link['href']} + => "
          link.set_attribute('href', link['href'].gsub("http://#{options[:offline_host]}", "http://#{options[:online_host]}"))
          puts link['href']
          doc_modified = true
        end
      end

      if doc_modified
        File.open(file_name, "w") {|file| file.write doc.to_html}      
      end
    end

    # Move the title page to the root and update the relative links
    puts "Moving Title Page and updating links"
    if options[:title_page]
      File.open("#{options[:output_path]}/start.html", "w") do |file|
        start_page_path = squeeze_path("./#{options[:page_path].gsub(options[:output_path], '')}/#{options[:title_page]}.html")
        file.write("<html><head><meta http-equiv='refresh' content=\"0;URL='#{start_page_path}'\"></head></html>")
      end
    end

    # DOWNLOAD IMAGES

    puts "Fetching #{images_to_fetch.count} images"
    images_to_fetch.uniq!
    FileUtils.mkdir_p(File.dirname image_manifest_path)
    File.open(image_manifest_path, "w") do |file|
      images_to_fetch.reject{|url| url =~ /maps.google/}.each do |url|
        file.write "#{url}\n"
      end
    end

    # # Fetch the images, remember to include a referrer because the server won't give the images out to just anyone
    puts `wget -i #{image_manifest_path} -H -p -P #{options[:image_path]} --referer=http://localhost:3000/aofe_encounters/`

    # Rename all images to their hashed name (all files end in html)
    images_to_fetch.each do |url|
      source_name = "#{options[:image_path]}/#{url.gsub('http://','')}index.html"
      dest_name = "#{options[:image_path]}/#{Digest::SHA2.hexdigest(url)}.jpg"
      if File.exists?(source_name)
        puts "Moving #{source_name} to #{dest_name}"
        FileUtils.mv(source_name, dest_name)
      else
        puts "Couldn't find #{source_name}"
      end
    end

    # CLEANUP

    puts "Cleaning up"

    # Remove the image_manifest
    File.delete(image_manifest_path)

    # Remove all the empty directories from the image hierarchy
    Dir.glob("#{options[:image_path]}/*").sort_by{|dir| -dir.length }.each do |directory|
      FileUtils.rm_rf directory if File.directory?(directory)
    end

    # ZIP it
    if options[:zipfile]
      Zip::ZipFile.open(options[:zipfile], Zip::ZipFile::CREATE) do |zipfile|
        Dir.glob("#{options[:output_path]}/**/*").each do |file_name|
          zipfile.add(file_name.gsub("#{options[:output_path]}/", ''), file_name) unless File.directory?(file_name)
        end
      end

      # Remove the unzipped files if we're delivering a zipfile
      FileUtils.rm_rf options[:output_path] if File.directory?(options[:output_path])
    end

    puts "Exported in #{Time.now - start} seconds"
  end
end