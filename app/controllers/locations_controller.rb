class LocationsController < ApplicationController

  def index
    @locations = collection.results(:page => params[:page], :per_page => 12, :order => :name)
  end
  
  def show
    @location = Location.find(params[:id])
    @locations = @location.children.order('local_name ASC')
  end  

  def autocomplete
    render :json => collection.autocomplete_tags(:limit => 10)
  end

  protected

  def collection
    LocationSearch.new(params[:q])
  end
end
