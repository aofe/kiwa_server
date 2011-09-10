class EncountersController < ApplicationController  
  def index
    @encounters = Encounter.search(params[:query]).order(:name).page(params[:page]).per(25)
  end
  
  def show
    @encounter = Encounter.find(params[:id])
  end
end