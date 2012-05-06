class PeopleController <  GlintSearchController
  protected

  def klass
    Person
  end

  def search_options
  	super.merge(:order => :sort_name, :per_page => 36)
  end
end