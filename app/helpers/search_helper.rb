module SearchHelper
  def record_search(klass)
    form_tag polymorphic_path(klass), :method => :get do
      "".html_safe.tap do |output|
        output << text_field_tag(:query, params[:query], :placeholder => 'Search', :type => :search)
        if params[:query]
          no_query_params = params.dup
          no_query_params.delete(:query)
          output << " "
          output << link_to('Clear', url_for(no_query_params))
        end
      end      
    end
  end
end