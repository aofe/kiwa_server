module PeopleHelper
	def people_menu
    search_field(Person)
	end

  def person_menu(person)
    collect_button(person)
  end
end
