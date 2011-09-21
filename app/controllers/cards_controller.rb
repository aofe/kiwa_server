class CardsController < ApplicationController
  def index
    @cards = Card.search(params[:query]).default_order.page(params[:page]).per(25)
  end
  
  def show
    @card = Card.find(params[:id])
  end
end
