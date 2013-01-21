module LayoutHelper

	def page_class
    output = []
		output << "with_sidebar" if content_for?(:sidebar)
    output << "with_page_menu" if content_for?(:page_menu)
    return output.join(' ')
	end

  def section_link(menu_bar, klass, selected = false)
    menu_bar.menu_bar_content link_to(klass.model_name.human.pluralize, klass), :class => ('active' if selected)
  end

  def sections_menu(menu_bar, title, &block)
    menu_bar.menu_bar_content :class => 'dropdown' do
      output = link_to(title.html_safe + content_tag(:b, '', :class =>'caret'), "#", :class => 'dropdown-toggle', :'data-toggle' => 'dropdown')
      output << content_tag(:ul, yield("".html_safe), :class => 'dropdown-menu')
    end      
  end

  def page_title(record)
  	record.to_s
  end
end