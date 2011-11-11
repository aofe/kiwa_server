module EncountersHelper
  def encounter_show_menu_bar
    MenuBar.new(self, :toggle => true) do |menu|
      menu.group do |group|
        for encounter in @encounter.artefact.encounters
          group.menu_bar_item(link_to encounter.encounter_type.titleize, encounter, :title => "View the #{encounter.encounter_type.titleize} Encounter").selected(@encounter == encounter)
        end        
      end
    end
  end

  def encounter_sidebar(encounter)
    MenuBar.new(self, :class => "sidebar_menu") do |menu|
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Media')
        group.menu_bar_content(record_media(encounter.media_items))
      end
      menu.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')
        sidebar_record_relation(group, 'Expedition', encounter.related_expeditions)
        sidebar_record_relation(group, 'Voyage', encounter.related_voyages)
        sidebar_record_relation(group, 'Encounter', encounter.other_encounters.includes(:primary_media_item))
        sidebar_record_relation(group, 'Label', encounter.artefact.related_labels.includes(:primary_media_item))
        sidebar_record_relation(group, 'Location', encounter.related_locations)
      end
    end
  end

  def encounter_source_name(encounter)
    case encounter.encounter_type
    when 'source'
      "Museum of Archaeology and Anthropology, University of Cambridge"
    when 'aofe'
      "Artefacts of Encounter"
    end
  end
end