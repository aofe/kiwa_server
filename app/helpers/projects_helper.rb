module ProjectsHelper
  def project_menu(project)
    MenuBar.new self do |mb|
      mb.menu_bar_item link_to('Settings', edit_project_path(project))
    end
  end
end
