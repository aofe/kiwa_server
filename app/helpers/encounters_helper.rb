module EncountersHelper
  def encounter_show_menu_bar
    MenuBar.new(self) do |menu|
      for encounter in @encounter.other_encounters
        menu.add_menu_bar_item(link_to image_tag('flip.png') + " #{encounter.encounter_type.titleize}'s Encounter", encounter)
      end
    end
  end
end