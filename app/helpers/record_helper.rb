module RecordHelper
  def list_attributes(record, *attributes)
    options = attributes.last.is_a?(Hash) ? attributes.pop : {}

    if attributes.blank?
      attributes = record.class.content_columns.collect(&:name) - ['created_at', 'updated_at']
    end
    
    content_tag :dl, :class => 'dl-horizontal' do
      attributes.collect do |attribute|
        if attribute.is_a? Hash
          value = attribute.values.first
          attribute_name = attribute.keys.first
        elsif reflection = record.class.reflect_on_association(attribute)
          # If the value is actually another record or records, get that record's display name
          value = Array(record.send(attribute)).collect(&:display_name).join(', ')
          attribute_name = record.class.human_attribute_name(attribute)
        else
          value = process_references record.send(attribute)
          attribute_name = record.class.human_attribute_name(attribute)
        end

        content_tag(:dt, "#{attribute_name}:", :class => 'attribute_name') + " " + content_tag(:dd, value, :class => 'value') unless value.blank?
      end.join.html_safe
    end
  end

  def record_list(records, options = {})
    RecordList.new(self, records, options)
  end

  class RecordList
    def initialize(template, records, options = {})
      @template = template
      @entries = records.collect{|record| RecordListEntry.new(@template, record, options)}
      @options = options
    end

    def to_s
      @template.content_tag :div, @entries.collect(&:to_s).join.html_safe, :class => "record_list"
    end

    def content(text = nil,  &block)
      send_to_each(:content, text, &block)
    end

    def caption(text = nil, &block)
      send_to_each(:caption, text, &block)
    end

    private

    def send_to_each(method, *args, &block)
      @entries.each do |entry|
        entry.send method, *args, &block
      end

      return self            
    end    
  end

  class RecordListEntry
    def initialize(template, record, options = {})
      @template = template
      @record = record
      @options = options.reverse_merge :link_to => record
    end    

    def to_s
      if @content
        output = @content
      else
        output = @template.content_tag(:span, @record.display_name, :class => :name)
        output << @template.content_tag(:span, @record.description, :class => :description) if @record['description'].present?
      end

      if @options[:link_to]
        content = @template.link_to output, @options[:link_to], :class => :content
      else
        content = @template.content_tag :span, output, :class => :content
      end

      empty_cell = @template.content_tag :span, '', :class => :empty_cell

      return @template.content_tag :div, "#{content}#{empty_cell}#{@caption}".html_safe, :class => "record_list_entry #{@record.class.name.underscore}_entry"
    end


    def content(text = nil, &block)
      @content = @template.content_tag(:div) do
        if block_given?   
          yield @record
        else
          text
        end
      end

      return self
    end

    def caption(text = nil, &block)
      @caption = @template.content_tag(:div, :class => 'caption') do
        if block_given?        
          yield @record
        else
          @caption = text
        end
      end

      return self
    end    
  end


  def record_slide_table(records, options = {})
    RecordSlideTable.new(self, records, options)
  end

  def record_slide(record, options = {})
    RecordSlide.new(self, record, options)
  end

  class RecordSlideTable
    def initialize(template, records, options = {})
      @template = template
      @entries = records.collect{|record| RecordSlide.new(@template, record, options)}
      @options = options
    end

    def to_s
      @template.content_tag :div, @entries.collect(&:to_s).join.html_safe, :class => [@options[:class], 'record_slide_table'].compact.join(' ')
    end

    def caption(&block)
      @entries.each do |entry|
        entry.caption &block
      end

      return self      
    end
  end

  class RecordSlide
    def initialize(template, record, options = {})
      @template = template
      @record = record
      @options = options.reverse_merge :link_to => record
    end

    def to_s
      if @record.respond_to?(:primary_media_item) && @record.primary_media_item
        image = @template.image_tag(@record.primary_media_item.thumbnail_url(300), :class => 'image', :title => @record.display_name)
      else
        image = @template.content_tag(:div, 'No Image', :class => 'image')
      end

      if @options[:link_to]
        image = @template.link_to image, @options[:link_to]
      end

      return @template.content_tag :div, "#{image}#{@caption}".html_safe, :class => "record_slide #{@record.class.name.underscore}_slide"
    end

    def caption(text = nil, &block)
      if block_given?
        @caption = @template.content_tag(:div, :class => 'caption') do
          yield @record
        end
      else
        @caption = text
      end

      return self
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