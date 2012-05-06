module VoyagesHelper

  def voyages_menu
    MenuBar.new(self) do |mb|
      menu_bar_search(mb, url_for, :autocomplete_url => autocomplete_voyages_path)
    end
  end

  def voyage_sidebar(voyage)
    MenuBar.new(self, :theme => "sidebar_menu") do |menu|
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')        
        sidebar_record_relation(group, 'Encounter', voyage.related_encounters)
      end
    end
  end
end
