class VoyagesController <  GlintSearchController
  protected

  def klass
    Voyage
  end

  def default_order
    :ship_name
  end
end
