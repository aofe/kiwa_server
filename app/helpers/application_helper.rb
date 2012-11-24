module ApplicationHelper  
  include UserPreferences

  def flash_messages
    if flash[:notice]
      content_tag :div, (flash[:notice] + close_link).html_safe, :class => "alert alert-success"
    elsif flash[:alert]
      content_tag :div, (flash[:alert] + close_link).html_safe, :class => "alert alert-error"
    end
  end

  def close_link
    '<a class="close" data-dismiss="alert" href="#">&times;</a>'.html_safe
  end  
end
