class ExpeditionsController <  GlintSearchController
  protected

  def klass
    Expedition
  end

  def order
    :title
  end
end