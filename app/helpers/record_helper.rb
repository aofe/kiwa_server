module RecordHelper
  def list_attributes(record, *attributes)
    options = attributes.last.is_a?(Hash) ? attributes.pop : {}

    if attributes.blank?
      attributes = record.class.content_columns.collect(&:name) - ['created_at', 'updated_at']
    end
    
    content_tag :ul, :class => 'attribute_list' do
      attributes.collect do |attribute|
        if attribute.is_a? Hash
          value = attribute.values.first
          attribute_name = attribute.keys.first
        elsif reflection = record.class.reflect_on_association(attribute)
          # If the value is actually another record or records, get that record's display name
          value = Array(record.send(attribute)).collect(&:display_name).join(', ')
          attribute_name = record.class.human_attribute_name(attribute)
        else
          value = record.send(attribute)
          attribute_name = record.class.human_attribute_name(attribute)
        end

        unless options[:hide_blank] && value.blank?
          content_tag :li do
            content_tag(:span, "#{attribute_name}:", :class => 'attribute_name') + " " + content_tag(:span, value, :class => 'value')
          end
        end
      end.join.html_safe
    end
  end

  def record_list(records, options = {}, &block)
    ''.html_safe.tap do |output|
      records.each do |record|
        output << record_list_entry(record, options, &block)
      end
    end
  end

  def record_list_entry(record, options = {}, &block)
    if block_given?
      link_to record, :id => dom_id(record), :class => "record_list_entry #{record.class.model_name.underscore}" do
        yield record
      end
    else
      options.reverse_merge! :name => :display_name
      link_to record, :id => dom_id(record), :class => "record_list_entry #{record.class.model_name.underscore}"  do
        content_tag(:span, record.send(options[:name]), :class => 'name')
      end
    end
  end

  def record_slide_table(records, options = {})
    content_tag :div, :class => 'record_slide_table' do
      ''.html_safe.tap do |output|
        records.each do |record|
          output << record_slide(record, options)
        end
      end
    end
  end
  
  def record_slide(record, options = {})
    record_list_entry record, options do |record|
      if record.respond_to?(:primary_media_item) && record.primary_media_item
        image_tag record.primary_media_item.thumbnail_url(300), :class => 'thumbnail', :title => record.display_name
      else
        record.display_name
      end
    end
  end
    
  def record_media(media_items)
    output = media_items.collect{|media_item| media_thumbnail(media_item)}
    content_tag :div, output.join.html_safe, :id => 'record_media'
  end  
  
  # Creates entries for the sidebar using a the MenuBar class
  def sidebar_record_relation(sidebar, association_name, related_records)
    case association_name
    when Class
      association_name = association_name.model_name.human
    when String
      association_name = association_name.titleize
    end
    
    sidebar.menu pluralize(related_records.count, association_name), :menu_bar_content => {:class => ('inactive' if related_records.empty?)} do |menu|
      for record in related_records
        text = ''.html_safe
        text << media_thumbnail(record.primary_media_item, :size => 28, :link_to => nil) + " " if record.respond_to? :primary_media_item
        text << record.display_name
        
        menu.menu_item link_to(text, record)
      end
    end    
  end  
end