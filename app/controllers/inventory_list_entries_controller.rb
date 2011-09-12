class InventoryListEntriesController < ApplicationController
  def show
    @inventory_list_entry = InventoryListEntry.find(params[:id])
  end
end
