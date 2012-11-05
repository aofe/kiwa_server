module SearchHelper
  def search_field(klass, options = {})
    url = options.delete(:url) || polymorphic_path(klass)

    if respond_to?(:default_order)
      order = default_order 
      options.reverse_merge! :form_params => {:order => :score, :direction => :desc} # When we search, apply a sort order of relevance descending
      options.reverse_merge! :clear_url => params.merge(:q => nil, :order => order, :direction => :asc) # When we clear the search, go back to sorting by the default order    
    else
      options.reverse_merge! :clear_url => params.merge(:q => nil)
    end

    options.reverse_merge! :autocomplete_url => url_for([:autocomplete, klass]),
      :query_param         => :q,
      :input_html          => {:placeholder => "Filter..."},
      :main_form_submit    => button_tag(content_tag(:i, '', :class => 'icon-search icon-white'), :type => 'submit', :class => 'main_form_submit btn btn-success'),
      :clear_search_button => " ".html_safe + link_to(content_tag(:i, '', :class => 'icon-remove icon-white'), options.delete(:clear_url) || url, :class => 'btn btn-danger'),
      :dropdown_submit     => button_tag('Search', :type => 'submit', :class => 'dropdown_submit btn btn-success')

    if block_given?
      output = glint_search_fields(url, options) do |f|
        yield(f)
      end
    else
      output = glint_search_fields(url, options)
    end

    return content_tag :div, output, :class => 'menu_bar_search btn-group input-append'
  end
end