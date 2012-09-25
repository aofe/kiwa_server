class SearchesController < ApplicationController
  FACETS_TO_IGNORE = [:type, :first_name, :last_name]

  def index
    @searches = params[:q].present? ? searches : []
    # @inventory_list_entries = InventoryListEntry.search(params[:q]).default_order.page(params["inventory_list_entries_page"])
  end

  # Group all the different searches' autcomplete results and sort them 
  def autocomplete
    output = []
    searches.values
      .collect{|search| search.autocomplete_tags(:except => FACETS_TO_IGNORE, :order => :count, :limit => 10) }
      .flatten
      .group_by(&:value)
      .sort_by{|value, tags| -tags.collect(&:count).sum }
      .first(10)
      .each { |value, tags| output << tags.first.as_json.merge(:count => tags.collect(&:count).sum) }

    render :json => output
  end

  private

  def searches
    {
      SourceEncounter => EncounterSearch.new(SourceEncounter, params[:q]),
      AOFEEncounter   => EncounterSearch.new(AOFEEncounter, params[:q]),
      Voyage          => VoyageSearch.new(params[:q]),
      Person          => PersonSearch.new(params[:q]),
      Label           => LabelSearch.new(params[:q]),
      Card            => CardSearch.new(params[:q]),
      Inventory       => InventorySearch.new(params[:q])
    }
  end
end