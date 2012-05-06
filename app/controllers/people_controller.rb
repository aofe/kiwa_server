class PeopleController < ApplicationController

  def index
    @people = collection.results(:page => params[:page], :per_page => 12, :order => :sort_name)
  end
  
  def show
    @person = Person.find(params[:id])
  end  

  def autocomplete
    render :json => collection.autocomplete_tags(:limit => 10, :except => :name)
  end

  protected

  def collection
    PersonSearch.new(params[:q])
  end
end
