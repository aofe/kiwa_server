module CardsHelper

	def cards_menu
	end

	def card_source_name(card)
		card.institution.try(:long_name)
	end

  def card_sidebar(card)
    MenuBar.new(self, :theme => "sidebar_menu") do |menu|
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')        
        sidebar_record_relation(group, Project, card.projects.public)        
      end
    end
  end
end
