module LabelsHelper
  def labels_menu
    view_toggles + sort_menu(:id_tag) + search_field(Label)
  end

  def label_sidebar(label)
    MenuBar.new(self, :theme => "sidebar_menu") do |menu|
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')        
        sidebar_record_relation(group, 'Encounter', label.related_encounters)
        sidebar_record_relation(group, Project, label.projects.public)
      end
    end
  end
  
  def label_source_name(label)
    label.institution.try(:long_name)
  end  
end