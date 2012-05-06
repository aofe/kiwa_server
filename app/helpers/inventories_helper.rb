module InventoriesHelper
  def inventories_menu
    MenuBar.new(self) do |mb|
      menu_bar_search(mb, url_for, :autocomplete_url => autocomplete_inventories_path)
    end
  end	
end
