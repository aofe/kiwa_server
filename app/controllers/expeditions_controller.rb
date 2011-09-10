class ExpeditionsController < ApplicationController
  
  def index
    @expeditions = Expedition.includes(:voyages).search(params[:query]).order(:title).page(params[:page]).per(25)
  end
  
  def show
    @expedition = Expedition.find(params[:id])
  end  
end
