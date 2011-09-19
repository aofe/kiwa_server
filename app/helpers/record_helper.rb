module RecordHelper
  def list_attributes(record, *attributes)
    content_tag :ul, :class => 'attribute_list' do
      attributes.collect do |attribute|
        # If the value is actually another record, get that record's display name
        value = record.send(attribute)
        value = value.display_name if value.is_a? ActiveRecord::Base
        content_tag :li do
          content_tag(:span, record.class.human_attribute_name(attribute) + ":", :class => 'attribute_name') + " " + content_tag(:span, value, :class => 'value')
        end
      end.join('').html_safe
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
  
  def record_slide(record)
    render 'shared/record_slide', :record => record
  end
  
  def record_relation(name, related_records)
    classNames = ['sidebar_option', 'record_relation']
    classNames << 'inactive' if related_records.empty?
    content_tag :span, pluralize(related_records.count, name), :related_records => related_records_popup_content(related_records), :class => classNames.join(' ')
  end
  
  def related_records_popup_content(related_records)
    related_records.sort_by(&:display_name).collect do |record|
      output = ''
      output = media_thumbnail(record.primary_media_item, :size => 50, :link_to => nil) if record.respond_to? :primary_media_item
      output << " " + record.display_name
      link_to output, record, :class => 'sidebar_option'
    end.join('')
  end
  
  def record_media(media_items)
    output = media_items.collect{|media_item| media_thumbnail(media_item)}
    content_tag :div, output.join.html_safe, :id => 'record_media'
  end  
end