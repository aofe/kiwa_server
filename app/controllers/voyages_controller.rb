class VoyagesController < ApplicationController
  
  def index
    @voyages = Voyage.includes(:expedition).search(params[:query]).order('expeditions.title ASC, voyages.ship_name ASC').page(params[:page]).per(25)
  end
  
  def show
    @voyage = Voyage.find(params[:id])
  end  
end
