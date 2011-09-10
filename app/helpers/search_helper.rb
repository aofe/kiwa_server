module SearchHelper
  def record_search(klass)
    render 'shared/record_search', :klass => klass
  end
end