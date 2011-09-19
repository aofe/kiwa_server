module LocationHelper
  def location_nav_links(location)
    # Ensure we sort by the distance of the ancestor link because if the ancestors
    # are eager loaded, then they lose the sql ordering that ensures sort order
    sorted_links = location.ancestor_links.sort{|a,b| b.distance <=> a.distance}
    
    sorted_links = sorted_links.collect do |al|
      if al != sorted_links.last
        link_to al.ancestor.local_name, al.ancestor
      else
        al.ancestor.local_name
      end
    end
    sorted_links.unshift link_to('Locations', locations_path)
    
    return sorted_links.join(' / ').html_safe
  end
  
  def location_map(location, html_options = {})
    marker = "&markers=size:mid"
    marker << "|#{location.name}"
    
    image_tag("http://maps.google.com/maps/api/staticmap?size=250x250&maptype=hybrid#{marker}&sensor=false", html_options)
  end  
end


