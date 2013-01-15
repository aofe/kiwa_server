module ButtonsHelper
  def submit_button(text = 'Save', klass = '')
    button_tag text, :type => :submit, :class => "btn #{klass}"
  end

  def print_button(html_options = {})
    html_options[:class] = [html_options[:class], 'btn'].compact.join(' ')
    html_options[:onclick] = 'print()'

    content_tag :span, content_tag(:i, '', :class => 'icon-print') + ' Print', html_options
  end

  def help_button
    icon = '<i class="icon-question-sign"></i> '.html_safe
    link_to icon + 'Help', "#help-modal", :class => 'btn', :data => {:toggle => 'modal'}
  end

  # Button back to the url
  # Back url can be overridden by params[:back], allowing secondary parents, like a project, to point leaf pages back to itself
  def back_button(url)
    icon = '<i class="icon-chevron-left"></i> '.html_safe
    link_to icon + 'Back', params[:back].presence || url, :class => 'btn'
  end

  def new_button(url, options = {})
    icon = '<i class="icon-plus icon-white"></i> '.html_safe
    text = options[:text] || 'New'
    link_to icon + text, url, :class => ['btn btn-primary', options[:class]].join(' ')
  end

  def edit_button(url, options = {})
    icon = '<i class="icon-edit"></i> ' unless options[:mini]
    url = [:edit, url].flatten if url.is_a?(ActiveRecord::Base) || url.is_a?(Array)
    link_to("#{icon} Edit".html_safe, url, :class => "btn #{'btn-mini' if options[:mini]}")
  end

  def delete_button(url, options = {}, &block)
    options.merge! :method => :delete, :class => ['btn btn-danger', options[:class]].join(' ')

    if block_given?
      content_tag(:span, '<i class="icon-trash icon-white"></i> '.html_safe + 'Delete', :class => options[:class], :data => {:toggle => 'modal'}, :href => '#mymodal') + 
      content_tag(:div, :class => 'modal hide', :id => 'mymodal') do
        content_tag(:div, :class => 'modal-body', &block) +
        content_tag(:div, :class => 'modal-footer') do
          link_to('Cancel', '#', :class => 'btn', :data => {:dismiss => 'modal'}) + 
          link_to('<i class="icon-trash icon-white"></i> '.html_safe + 'Delete', url, options)
        end
      end
    else      
      link_to('<i class="icon-trash icon-white"></i> '.html_safe + 'Delete', url, options.reverse_merge(:confirm => 'Are you sure?'))
    end
  end

  def nested_delete_button(form)
    form.link_to_remove '<i class="icon-trash icon-white"></i> '.html_safe + "Delete", :class => 'btn btn-danger pull-right'
  end

  def export_button(url, options = {})
    return ''  if offline_mode?

    options.reverse_merge! :text => 'Download Report'
    icon = '<i class="icon-download-alt"></i> '.html_safe
    link_to icon + options[:text], url, :class => 'btn'
  end

  def collect_button(record, html_options = {})
    return '' if offline_mode? || !user_signed_in?

    @add_to_project_modal = true
    html_options.reverse_merge! :class => 'save_to_project btn btn-primary', :role => 'button', :data => {:toggle => 'modal', :item_type => record.class.name, :item_id => record.id}
    link_to('Collect', {:anchor => 'add_to_project_modal'}, html_options)
  end

  def button_separator
    "&nbsp;&nbsp;".html_safe
  end

    # TODO: Make MenuBar work with bootstrap button styling so we don't need to create our own
  def view_toggles
    return ''  if offline_mode?

    output =  link_to('<i class="icon-th-large"></i>'.html_safe, params.merge(:view => 'slides'), :class => [:btn, ('active' unless preferences[:view] == 'list')]) 
    output << link_to('<i class="icon-align-justify"></i>'.html_safe, params.merge(:view => 'list'), :class => [:btn, ('active' if preferences[:view] == 'list')])
    content_tag :div, output, :class => 'btn-group'    
  end

  def sort_menu(*facets)
    return '' if offline_mode?

    if preferences[:direction].to_s == 'desc'
      arrow = link_to(content_tag(:i, '', :class => 'icon-chevron-down'), params.merge(:direction => :asc), :class => "btn dropdown-toggle", :title => 'Sorting Descending')
    else
      arrow = link_to(content_tag(:i, '', :class => 'icon-chevron-up'), params.merge(:direction => :desc), :class => "btn dropdown-toggle", :title => 'Sorting Ascending')
    end

    content_tag :div, :class => "btn-group" do
      button_tag("Sorting by " + I18n.t(order, :scope => [:glint, :facets], :default => order.to_s).titleize, :class => 'btn', :class => 'btn', 'data-toggle' => 'dropdown') + arrow +
      content_tag(:ul, :class => 'dropdown-menu') do
        facets.collect do |facet|
          link_to I18n.t("glint.facets.#{facet}", :default => facet.to_s).titleize, params.merge(:order => facet)
        end.join.html_safe
      end      
    end
  end
end