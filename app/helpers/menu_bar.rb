class MenuBar
  TOGGLE_MENU_CLASS = 'toggle_menu'
  
  MENU_BAR_CLASS = 'menu_bar'
  MENU_BAR_ITEM_WRAPPER_CLASS = 'menu_bar_item_wrapper'
  MENU_BAR_ITEM_CLASS = 'menu_bar_item'
  
  SELECTED_CLASS = 'selected'
  GROUPED_CLASS = 'grouped'
  
  def initialize(template, options = {})
    @template = template
    @options = options

    @menu_bar_items = []
    
    if block_given?
      yield self
    end
  end
  
  def group
    @grouped = true
    yield self
    return self
  ensure
    @grouped = false
  end
  
  def menu_bar_item(content, options = {})
    options.merge!(:grouped => @grouped) # If we're in a grouped context, pass that information to the menu bar item
    mbi = MenuBarItem.new(@template, content, options)
    @menu_bar_items << mbi

    return mbi
  end
  
  def to_s
    @template.content_tag :ul, @menu_bar_items.collect(&:to_s).join.html_safe, html_options
  end
  
  def html_options
    html_opts = @options.dup

    # Set up the css class
    css_class = [MENU_BAR_CLASS, @options[:class]]
    css_class << TOGGLE_MENU_CLASS if html_opts.delete(:toggle)
    css_class.compact.join(' ')
    html_opts[:class] = css_class
    
    return html_opts
  end
  
  # MENU BAR ITEM
  class MenuBarItem
    def initialize(template, content, options = {})
      @template = template
      @content = content
      @options = options
    end
    
    def to_s
      @template.content_tag :li, @content, wrapper_options do
        @template.content_tag :div, @content, html_options
      end
    end
    
    def selected(condition = :unset)
      @options[:selected] = (condition == :unset ? true : condition)
    end
    
    def wrapper_options
      wrapper_opts = {}

      # Set up the css class
      wrapper_opts[:class] = [MENU_BAR_ITEM_WRAPPER_CLASS]
      wrapper_opts[:class] << GROUPED_CLASS if @options[:grouped]
      wrapper_opts[:class] = wrapper_opts[:class].compact.join(' ')

      return wrapper_opts      
    end
    
    def html_options
      html_opts = {}

      # Set up the css class
      html_opts[:class] = [MENU_BAR_ITEM_CLASS]
      html_opts[:class] << SELECTED_CLASS if @options[:selected]
      html_opts[:class] = html_opts[:class].compact.join(' ')      
      
      return html_opts
    end
  end
end