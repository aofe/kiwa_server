class VoyagesController < ApplicationController
  
  def index
    @voyages = Voyage.includes(:expedition).search(params[:query]).default_order.page(params[:page]).per(25)
  end
  
  def show
    @voyage = Voyage.find(params[:id])
  end  
end
