module ProjectsHelper
  def project_menu(project)
    "".html_safe.tap do |output|
      output << link_to('<i class="icon-wrench"></i>'.html_safe, edit_project_path(project), :class => 'btn') + ' ' if project.user == current_user
      output << view_toggles + ' '
      output << search_field(ProjectItem, :url => project, :form_params => {:project_id => project.id})
    end
  end
end
