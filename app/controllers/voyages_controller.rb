class VoyagesController <  GlintSearchController
  protected

  def klass
    Voyage
  end

  def order
    :ship_name
  end
end
