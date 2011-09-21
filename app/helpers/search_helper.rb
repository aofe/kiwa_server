module SearchHelper
  def record_search(klass)
    render 'shared/record_search', :path => polymorphic_path(klass)
  end
  
  def any_record_search
    render 'shared/record_search', :path => searches_path
  end
  
end