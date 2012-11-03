class LocationsController < GlintSearchController

  def show
    @location = Location.find(params[:id])
    @locations = @location.children.order('local_name ASC')
  end  

  def klass
    Location
  end

  def default_order
    :name
  end
end
