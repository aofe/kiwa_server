class LabelsController < ApplicationController
  def index
    @labels = Label.search(params[:query]).default_order.page(params[:page]).per(25)
  end
  
  def show
    @label = Label.find(params[:id])
  end  
end
