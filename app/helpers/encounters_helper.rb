module EncountersHelper
  def encounter_show_menu_bar
    MenuBar.new(self, :toggle => true) do |menu|
      menu.group do |group|
        for encounter in @encounter.artefact.encounters
          group.menu_bar_item(link_to encounter.encounter_type.titleize, encounter).selected(@encounter == encounter)
        end        
      end
    end
  end
end