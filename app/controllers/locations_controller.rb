class LocationsController < ApplicationController
  
  def index
    @locations = Location.roots.order('name ASC').search(params[:query]).page(params[:page]).per(25)
  end
  
  def show
    @location = Location.find(params[:id])
    @locations = @location.children.order('local_name ASC')
  end  
end
