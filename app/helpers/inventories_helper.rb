module InventoriesHelper
  def inventories_menu
    sort_menu(:short_title, :size) + search_field(Inventory)
  end	
end
