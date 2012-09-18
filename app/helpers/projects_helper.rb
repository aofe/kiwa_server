module ProjectsHelper
  def project_menu(project)
    link_to('Settings', edit_project_path(project), :class => 'btn')
  end
end
