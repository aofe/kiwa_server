module CardsHelper
  def card_source_name(card)
    card.institution.try(:long_name)
  end
end
