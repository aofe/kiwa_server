module RecordHelper
  def list_attributes(record, *attributes)
    options = attributes.last.is_a?(Hash) ? attributes.pop : {}
    
    content_tag :ul, :class => 'attribute_list' do
      attributes.collect do |attribute|
         # If the value is actually another record or records, get that record's display name
        if reflection = record.class.reflect_on_association(attribute)
          value = Array(record.send(attribute)).collect(&:display_name).join(', ')
        else
          value = record.send(attribute)
        end

        unless options[:hide_blank] && value.blank?
          content_tag :li do
            content_tag(:span, record.class.human_attribute_name(attribute) + ":", :class => 'attribute_name') + " " + content_tag(:span, value, :class => 'value')
          end
        end
      end.join.html_safe
    end
  end
  
  def record_list(records, name_method = :display_name)
    content_tag :ul, :class => 'record_list' do
      "".html_safe.tap do |output|
        for record in records
          output << content_tag(:li, link_to(record.send(name_method), record))
        end
      end
    end
  end
  
  def record_slide(record, caption = :default)
    render 'shared/record_slide', :record => record, :caption => caption
  end
    
  def record_media(media_items)
    output = media_items.collect{|media_item| media_thumbnail(media_item)}
    content_tag :div, output.join.html_safe, :id => 'record_media'
  end  
  
  # Creates entries for the sidebar using a the MenuBar class
  def sidebar_record_relation(sidebar, association_name, related_records)
    
    sidebar.menu pluralize(related_records.count, association_name), :wrapper_options => {:class => 'sidebar_submenu inactive'} do |menu|
      for record in related_records
        text = record.display_name.html_safe
        text << ' ' + media_thumbnail(record.primary_media_item, :size => 50, :link_to => nil) if record.respond_to? :primary_media_item
        menu.menu_item(link_to(text, record), :html_options =>{:class => 'sidebar_suboption'})
      end
    end    
  end  
end