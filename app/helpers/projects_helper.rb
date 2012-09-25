module ProjectsHelper
  def project_menu(project)
    view_toggles + ' ' + link_to('<i class="icon-wrench"></i>'.html_safe, edit_project_path(project), :class => 'btn') + ' ' + search_field(ProjectItem, :form_params => {:project_id => project.id})
  end
end
