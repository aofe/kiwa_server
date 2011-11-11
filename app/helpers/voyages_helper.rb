module VoyagesHelper
  def voyage_sidebar(voyage)
    MenuBar.new(self, :class => "sidebar_menu") do |menu|
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')        
        sidebar_record_relation(group, 'Encounter', voyage.related_encounters)
      end
    end
  end
end
