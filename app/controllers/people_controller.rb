class PeopleController <  GlintSearchController
  protected

  def klass
    Person
  end

  def search_options
  	super.merge(:per_page => 36)
  end

  def default_order
    :sort_name
  end
end