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
    # sorted_links.unshift link_to('Locations', locations_path)
    
    return sorted_links.join(' / ').html_safe
  end
  
  def location_map(location, size = '250x250', html_options = {})
    marker = "&markers=size:mid"
    marker << "|#{location.name}"
    
    image_tag("http://maps.google.com/maps/api/staticmap?size=#{size}&maptype=hybrid#{marker}&sensor=false", html_options)
  end  
  
  def location_sidebar(location)
    MenuBar.new(self, :theme => "sidebar_menu") do |menu|
      menu.menu_bar_content(content_tag :div, location_map(location, '390x250', :class => 'media_thumbnail'), :id => 'record_media')
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')
        sidebar_record_relation(group, 'Encounter', location.related_with_descendants(:encounter).includes(:primary_media_item))
        sidebar_record_relation(group, 'Voyage', location.related_with_descendants(:voyage))
      end
    end
  end

  def locations_menu
    sort_menu(:name) + search_field(Location)
  end  
end


