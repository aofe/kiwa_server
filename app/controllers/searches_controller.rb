class SearchesController < ApplicationController
  def index
    @voyages = Voyage.search(params[:query]).default_order
    @people = Person.search(params[:query]).default_order
    @maa_encounters = MAAEncounter.search(params[:query]).default_order
    @aoe_encounters = AOEEncounter.search(params[:query]).default_order
    @inventories = Inventory.search(params[:query]).default_order
    @inventory_list_entries = InventoryListEntry.search(params[:query]).default_order
  end
end
