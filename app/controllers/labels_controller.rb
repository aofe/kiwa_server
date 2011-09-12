class LabelsController < ApplicationController
  def index
    @labels = Label.search(params[:query]).order(:id).page(params[:page]).per(25)
  end
  
  def show
    @label = Label.find(params[:id])
  end  
end
