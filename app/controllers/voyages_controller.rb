class VoyagesController < ApplicationController
  
  def index
    @voyages = collection.results(:page => params[:page], :per_page => 12, :order => :ship_name)
  end
  
  def show
    @voyage = Voyage.find(params[:id])
  end  

  def autocomplete
    render :json => collection.autocomplete_tags(:limit => 10)
  end

  protected

  def collection
    VoyageSearch.new(params[:q])
  end
end
