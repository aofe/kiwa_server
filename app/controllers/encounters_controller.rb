class EncountersController < ApplicationController
  include EncountersHelper # So we can access encounter_type method

  def index
    @encounters = encounter_type.search(params[:query]).default_order.page(params[:page]).per(25)
  end

  def show
    @encounter = Encounter.find(params[:id])
  end
end