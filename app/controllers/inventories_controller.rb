class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.default_order.page(params[:page]).per(25)
  end
  
  def show
    @inventory = Inventory.find(params[:id])
  end
end
