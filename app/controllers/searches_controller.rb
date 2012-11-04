class SearchesController < ApplicationController
  def index
    @searches = params[:q].present? ? searches : []
    # @inventory_list_entries = InventoryListEntry.search(params[:q]).default_order.page(params["inventory_list_entries_page"])
  end

  private

  def searches
    {
      SourceEncounter => SourceEncounterSearch.new(params[:q]),
      AOFEEncounter   => AOFEEncounterSearch.new(params[:q]),
      Voyage          => VoyageSearch.new(params[:q]),
      Person          => PersonSearch.new(params[:q]),
      Label           => LabelSearch.new(params[:q]),
      Card            => CardSearch.new(params[:q]),
      Inventory       => InventorySearch.new(params[:q])
    }
  end
end