module CardsHelper

	def cards_menu
	end

	def card_source_name(card)
		card.institution.try(:long_name)
	end
end
