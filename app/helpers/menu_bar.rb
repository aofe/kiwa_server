class MenuBar
  MENU_BAR_CLASS = 'menu_bar'
  MENU_BAR_ITEM_WRAPPER_CLASS = 'menu_bar_item_wrapper'
  MENU_BAR_ITEM_CLASS = 'menu_bar_item'
  
  def initialize(template)
    @template = template
    @menu_bar_items = []
    
    if block_given?
      yield self
    end
  end
  
  def add_menu_bar_item(content)
    @menu_bar_items << MenuBarItem.new(@template, content)
  end
  
  def to_s
    @template.content_tag :ul, @menu_bar_items.collect(&:to_s).join.html_safe, :class => MENU_BAR_CLASS
  end
  
  class MenuBarItem
    def initialize(template, content)
      @template = template
      @content = content
    end
    
    def to_s
      @template.content_tag :li, @content, :class => MENU_BAR_ITEM_WRAPPER_CLASS do
        @template.content_tag :div, @content, :class => MENU_BAR_ITEM_CLASS
      end
    end
  end
end