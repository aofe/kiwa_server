class PeopleController < ApplicationController
  def index
    @people = Person.order('first_name ASC, last_name ASC').page(params[:page]).per(25)
  end
  
  def show
    @person = Person.find(params[:id])
  end  
end
