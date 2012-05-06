class SearchesController < ApplicationController
  def index
  	return unless params[:q]
    @voyages = VoyageSearch.new(params[:q]).results
    @people = PersonSearch.new(params[:q]).results
    @source_encounters = EncounterSearch.new(SourceEncounter, params[:q]).results(:include =>:primary_media_item)
    @aofe_encounters = EncounterSearch.new(AOFEEncounter, params[:q]).results(:include =>:primary_media_item)
    @labels = LabelSearch.new(params[:q]).results
    @cards = CardSearch.new(params[:q]).results
    @inventories = InventorySearch.new(params[:q]).results
    @inventory_list_entries = InventoryListEntry.search(params[:q]).default_order
  end
end
