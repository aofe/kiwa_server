class ExpeditionsController < ApplicationController
  
  def index
    @expeditions = Expedition.includes(:voyages).search(params[:query]).default_order.page(params[:page]).per(25)
  end
  
  def show
    @expedition = Expedition.find(params[:id])
  end  
end
