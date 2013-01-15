module ProjectsHelper
  def project_menu(project)
    "".html_safe.tap do |output|
      output << link_to('<i class=" icon-download-alt"></i> Download'.html_safe, export_project_path(project), :class => 'btn', :title => 'Download Offline Copy') + ' ' unless offline_mode?
      output << link_to('<i class="icon-wrench"></i>'.html_safe, edit_project_path(project), :class => 'btn', :title => 'Settings') + ' ' if project.user == current_user && !offline_mode?
      output << view_toggles + ' '
      output << search_field(ProjectItem, :url => project, :form_params => {:project_id => project.id})
    end
  end
end
