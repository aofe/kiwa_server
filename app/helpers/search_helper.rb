module SearchHelper
	def search_menu
		MenuBar.new(self) do |mb|
			menu_bar_search(mb, searches_path)
		end
	end
	
	def record_search(klass)
		render 'shared/record_search', :path => polymorphic_path(klass)
	end
end