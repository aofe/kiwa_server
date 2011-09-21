class PeopleController < ApplicationController
  def index
    @people = Person.search(params[:query]).default_order.page(params[:page]).per(25)
  end
  
  def show
    @person = Person.find(params[:id])
  end  
end
