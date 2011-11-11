module InventoryListEntriesHelper
  def inventory_list_entry_sidebar(inventory_list_entry)
    MenuBar.new(self, :class => "sidebar_menu") do |menu|
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')
        sidebar_record_relation(group, 'Other List Entry', inventory_list_entry.related_inventory_list_entries)
        sidebar_record_relation(group, 'Encounter', inventory_list_entry.related_encounters)
      end
    end
  end
end
