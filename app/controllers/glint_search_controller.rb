class GlintSearchController < ApplicationController  
  caches_action :autocomplete, :cache_path => :autocomplete_cache

  def index
  	instance_variable_set "@#{klass.name.underscore.pluralize}", collection.results(search_options)
  end
  
  def show
  	instance_variable_set "@#{klass.name.underscore}", klass.find(params[:id])
  end  

  def autocomplete
    render :json => collection.autocomplete_tags(autocomplete_options)
  end

  protected

  def collection
    @collection ||= klass.search_class.new(params[:q])
  end

  def klass
  	raise NotImplementedError
  end

  def search_options
  	{:page => params[:page], :per_page => 12, :order => order}
  end

  def autocomplete_options
    {:limit => 10}
  end

  def order
    nil
  end

  def autocomplete_cache_url
    "autocomplete/#{@collection.cache_key}"
  end
end