module ProjectsHelper
  def project_menu(project)
    "".html_safe.tap do |output|
      output << view_toggles + ' '
      output << link_to('<i class="icon-wrench"></i>'.html_safe, edit_project_path(project), :class => 'btn') + ' ' if project.user == current_user
      output << search_field(ProjectItem, :form_params => {:project_id => project.id})
    end
  end
end
