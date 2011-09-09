class EncountersController < ApplicationController  
  def index
    @encounters = Encounter.search(params[:query]).page(params[:page]).per(25)
  end
  
  def show
    @encounter = Encounter.find(params[:id])
  end
end