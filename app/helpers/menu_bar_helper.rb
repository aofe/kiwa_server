module MenuBarHelper
  def menu_bar_search(menu, url, options = {})
    clear_url = options.delete(:clear_url) || url
    
    options.reverse_merge! :size => 60, :placeholder => 'Search', :query_param => :q
    options[:'data-autocomplete-url'] = options[:autocomplete_url] if options[:autocomplete_url]
    options[:'data-autocomplete-param'] = options[:autocomplete_param] if options[:autocomplete_param]

    form = form_tag(url, :method => :get) do
      "".html_safe.tap do |output|
        # Add the search field
        output << text_field_tag(options[:query_param], params[options[:query_param]], options)
        
        # Add any extra form params that have been passed
        Array(options[:form_params]).each do |name, value|
          output << hidden_field_tag(name, value)
        end
      end
      
    end
    
		menu.group do |group|
      group.menu_bar_content("#{options[:label]} ".html_safe + form)
      group.menu_bar_item(link_to('Clear', clear_url)) if params[options[:query_param]].present?
	  end    
  end
  
  def print_button(menu)
    menu.menu_bar_item(link_to(image_tag('icons/printer.png'), 'javascript:window.print()', :title => 'Print'))
  end
end