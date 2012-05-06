module CardsHelper

	def cards_menu
	    MenuBar.new(self) do |mb|
	      menu_bar_search(mb, url_for, :autocomplete_url => autocomplete_cards_path)
	    end		
	end

	def card_source_name(card)
		card.institution.try(:long_name)
	end
end
