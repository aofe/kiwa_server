class SearchesController < ApplicationController
  def index
    @voyages = VoyageSearch.new(params[:query]).results
    @people = Person.search(params[:query]).default_order
    @source_encounters = EncounterSearch.new(SourceEncounter, params[:query]).results(:include =>:primary_media_item)
    @aofe_encounters = EncounterSearch.new(AOFEEncounter, params[:query]).results(:include =>:primary_media_item)
    @inventories = Inventory.search(params[:query]).default_order
    @inventory_list_entries = InventoryListEntry.search(params[:query]).default_order
  end
end
