class EncountersController < ApplicationController
  include EncountersHelper # So we can access encounter_type method

  def index
    @encounters = collection.results(:page => params[:page], :per_page => 12)
  end

  def show
    @encounter = Encounter.find(params[:id])
  end

  def autocomplete
    render :json => collection.autocomplete_tags(:limit => 10, :except => :type)
  end

  protected

  def collection
    EncounterSearch.new(encounter_type, params[:q])
  end
end