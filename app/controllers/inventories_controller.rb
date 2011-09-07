class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.page(params[:page]).per(25)
  end
  
  def show
    @inventory = Inventory.find(params[:id])
  end
end
