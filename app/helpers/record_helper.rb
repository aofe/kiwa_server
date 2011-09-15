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
  
  def record_list(records)
    content_tag :ul, :class => 'record_list' do
      "".html_safe.tap do |output|
        for record in records
          output << content_tag(:li, link_to(record.display_name, record))
        end
      end
    end
  end
  
  def record_slide(record)
    render 'shared/record_slide', :record => record
  end
  
  def record_relation(name, related_records)
    link_to(pluralize(related_records.count, name), '', :class => 'record_relation', :onclick => 'alert("under construction"); return false')
  end
  
  def record_media(media_items)
    output = media_items.collect{|media_item| media_thumbnail(media_item)}
    content_tag :div, output.join.html_safe, :id => 'record_media'
  end  
end