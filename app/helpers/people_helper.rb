module PeopleHelper
	def people_menu
    sort_menu(:sort_name, :first_name) + search_field(Person)
	end

  def person_menu(person)
    collect_button(person)
  end
end
