module ExpeditionsHelper
  def expedition_sidebar(expedition)
    MenuBar.new(self, :theme => "sidebar_menu") do |menu|
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')
        sidebar_record_relation(group, 'Encounter', expedition.related_encounters)
      end
    end
  end

  def expedition_menu
    search_field(Expedition)
  end
end
