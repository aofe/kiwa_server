class EncountersController < ApplicationController
  
  def index
    @encounters = Encounter.limit(20)
  end
  
  def show
    @encounter = Encounter.find(params[:id])
  end
    
  
end