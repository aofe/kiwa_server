class ExpeditionsController <  GlintSearchController
  protected

  def klass
    Expedition
  end

  def default_order
    :title
  end
end