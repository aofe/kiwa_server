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

  def back_button(url)
    icon = '<i class="icon-chevron-left"></i> '.html_safe
    link_to icon + 'Back', url, :class => 'btn'
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
    options.reverse_merge! :text => 'Download Report'
    icon = '<i class="icon-download-alt"></i> '.html_safe
    link_to icon + options[:text], url, :class => 'btn'
  end

  def collect_button(record, html_options = {})
    @add_to_project_modal = true
    html_options.reverse_merge! :class => 'save_to_project btn btn-primary', :role => 'button', :data => {:toggle => 'modal', :item_type => record.class.name, :item_id => record.id}
    link_to('Collect', {:anchor => 'add_to_project_modal'}, html_options)
  end

  def button_separator
    "&nbsp;&nbsp;".html_safe
  end
end