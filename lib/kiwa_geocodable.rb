module KIWAGeocodable
  # Creates a bunch of locations given a string of KIWA data
  def geocode_field(field)
    location_string = self.send(field)
    return if location_string.blank?
    
    puts "\nparsing #{location_string}"

    # Clear out anything in {} () (Some references seem to use these)
    location_string.gsub!(/[{(].+?[})]/,'')

    # Clear out any non-name characters
    location_string.gsub!(/[?]/,'')
    
    for location_name in location_string.split(/,/).uniq.select(&:present?)
      last_location = nil # Parent location to this location      
      
      # Split on ;
      location_names = location_name.split(/\s*;\s*/)
      location_names = location_names.collect(&:strip)
      location_names.each_with_index do |local_name, index|
        name = location_names[0..index].reverse.join(', ')
        location = Location.find_or_initialize_by_name_and_local_name(:name => name, :local_name => local_name)
        if location.new_record?

          puts "Geocoding #{name}"
          results = Geocoder.search(name)

          if result = results.first
            location.latitude = result.latitude
            location.longitude = result.longitude
          end
          location.save!
          # Link this new location to the last_location
          if last_location
            location.add_parent(last_location)
            puts "#{location.name} is a child of #{last_location.name}"
          end
        end
        
        # Make this the parent for the next iteration
        last_location = location
      end
      # Link the record to the location
      self.relates_to!(last_location)
    end      
  end
  
  def old_geocode_field(field)
    location_string = self.send(field)
    puts "\nparsing #{location_string}"
    for location_name in location_string.gsub('?','').split(/,/).compact.uniq
      next unless location_name.present?
      # Remove polynesia and oceania because they don't tell the geocoder anything it didn't already know
      locations = location_name.split(/\s*;\s*/)
      if locations.length > 2
        locations.delete('Oceania')
        locations.delete('Polynesia')
      end
      
      # Reverse Join on commas so the location looks like "vancouver, bc, canada"
      location_name = locations.reverse.join(', ')

      puts "Geocoding #{location_name}"
      results = Geocoder.search(location_name)

      if result = results.first
        if result.country.present?
          attributes = {:name => result.country, :local_name => result.country} 

          # If there's no state, then the country gets the lat lng info
          attributes.merge!(:latitude => result.latitude, :longitude => result.longitude) if result.state.blank?
          country = Location.find_or_create_by_name_and_local_name(attributes)
          puts "found country: #{country.name}"
          self.relates_to!(country)
        end

        if result.state.present?
          state = Location.find_or_create_by_name_and_local_name(:name => "#{result.state}, #{result.country}", :local_name => result.state, :latitude => result.latitude, :longitude => result.longitude)
          puts "found state: #{state.name}"
          self.relates_to!(state)
        end

        if state && country
          puts "adding #{state.name} to #{country.name}"
          country.add_child(state)
        end
      end
    end
  end
end