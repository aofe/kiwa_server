module ApplicationHelper
  
  def section_link(klass)
    link_to klass.model_name.human.pluralize, klass
  end
end
