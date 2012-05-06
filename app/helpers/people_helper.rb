module PeopleHelper
	def people_menu
	    MenuBar.new(self) do |mb|
	      menu_bar_search(mb, url_for, :autocomplete_url => autocomplete_people_path)
	    end		
	end
end
