class CardsController < ApplicationController
  def index
    @cards = Card.search(params[:query]).order(:id).page(params[:page]).per(25)
  end
  
  def show
    @card = Card.find(params[:id])
  end
end
