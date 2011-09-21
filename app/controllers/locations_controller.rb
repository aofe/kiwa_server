class LocationsController < ApplicationController
  
  def index
    @locations = Location.roots.search(params[:query]).default_order.page(params[:page]).per(25)
  end
  
  def show
    @location = Location.find(params[:id])
    @locations = @location.children.order('local_name ASC')
  end  
end
