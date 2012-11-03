class GlintSearchController < ApplicationController
  caches_action :autocomplete, :cache_path => :autocomplete_cache
  helper_method :order, :default_order

  def index
  	instance_variable_set "@#{resource_name.pluralize}", collection.results(search_options)
  end
  
  def show
  	instance_variable_set "@#{resource_name}", klass.find(params[:id])
  end  

  def autocomplete
    render :json => collection.autocomplete_tags(autocomplete_options)
  end

  protected

  def collection
    @collection ||= klass.search_class.new(params[:q])
  end

  def resource_name
    klass.name.underscore
  end

  def klass
  	raise NotImplementedError
  end

  def search_options
  	{:page => params[:page], :per_page => 12, :order => {order => preferences[:direction]}}
  end

  def autocomplete_options
    {:limit => 10}
  end

  def order
    desired_order = preferences[:order][resource_name.pluralize].to_s
    if desired_order == 'score' || desired_order == 'primary_key' || klass.search_class.facet?(desired_order)
      desired_order
    else
      default_order
    end
  end

  def default_order
    :primary_key
  end

  def autocomplete_cache_url
    "autocomplete/#{@collection.cache_key}"
  end
end