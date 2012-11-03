class LabelsController <  GlintSearchController
  protected

  def klass
    Label
  end

  def default_order
    :id_tag
  end
end