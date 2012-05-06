module LabelsHelper
  def labels_menu
    MenuBar.new(self) do |mb|
      menu_bar_search(mb, url_for, :autocomplete_url => autocomplete_labels_path)
    end    
  end

  def label_sidebar(label)
    MenuBar.new(self, :theme => "sidebar_menu") do |menu|
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Media')
        group.menu_bar_content(record_media(@label.media_items))
      end      
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')        
        sidebar_record_relation(group, 'Encounter', label.related_encounters)
      end
    end
  end
  
  def label_source_name(label)
    label.institution.try(:long_name)
  end  
end