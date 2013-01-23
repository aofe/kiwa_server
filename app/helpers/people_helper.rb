module PeopleHelper
	def people_menu
    sort_menu(:sort_name, :first_name) + search_field(Person)
	end

  def person_menu(person)
    collect_button(person)
  end

  def person_sidebar(person)
    MenuBar.new(self, :theme => "sidebar_menu") do |menu|
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')        
        sidebar_record_relation(group, Project, person.projects.public)        
      end
    end
  end
end
