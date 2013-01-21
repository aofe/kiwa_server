module ExpeditionsHelper
  def expedition_sidebar(expedition)
    MenuBar.new(self, :theme => "sidebar_menu") do |mb|
      mb.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')
        sidebar_record_relation(group, 'Encounter', expedition.related_encounters)
      end
    end
  end

  def expedition_menu
    sort_menu(:title) + search_field(Expedition)
  end
end
