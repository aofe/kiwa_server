module InventoriesHelper
  def inventories_menu
    sort_menu(:short_title, :size) + search_field(Inventory)
  end	

  def inventory_sidebar(inventory)
    MenuBar.new(self, :theme => "sidebar_menu") do |menu|
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')
        sidebar_record_relation(group, Project, inventory.projects.public)
      end
    end
  end
end
