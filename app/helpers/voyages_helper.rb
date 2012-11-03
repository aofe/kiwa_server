module VoyagesHelper

  def voyages_menu
    sort_menu(:ship_name, :start_date) + search_field(Voyage)
  end

  def voyage_menu(voyage)
    collect_button(voyage)
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
