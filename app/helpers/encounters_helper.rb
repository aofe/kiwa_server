module EncountersHelper
  def encounter_show_menu_bar
    MenuBar.new(self) do |menu|
      for encounter in @encounter.other_encounters
        menu.add_menu_bar_item(link_to "See #{encounter.encounter_type}'s Encounter", encounter, :class => 'arrow-right')
      end
    end
  end
end