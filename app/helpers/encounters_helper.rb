module EncountersHelper

  def encounters_menu
    sort_menu(:accession_number, :name, :institution) + view_toggles + search_field(encounter_type)
  end

  def encounter_menu(encounter)
    collect_button(encounter)
  end

  def encounter_sidebar(encounter)
    MenuBar.new(self, :theme => "sidebar_menu") do |mb|
      mb.group do |group|
        group.menu_bar_content(content_tag :h2, 'Related')
        sidebar_record_relation(group, 'Expedition', encounter.related_expeditions)
        sidebar_record_relation(group, 'Voyage', encounter.related_voyages)
        sidebar_record_relation(group, SourceEncounter, encounter.other_source_encounters.includes(:primary_media_item))
        sidebar_record_relation(group, AOFEEncounter, encounter.other_aofe_encounters.includes(:primary_media_item))
        sidebar_record_relation(group, 'Label', encounter.artefact.related_labels.includes(:primary_media_item))
        sidebar_record_relation(group, 'Location', encounter.related_locations)
      end
    end
  end

  def encounters_page_title
    encounter_type.model_name.human.pluralize
  end

  def encounter_type
    case params[:encounter_type].to_s
    when 'Source'
      SourceEncounter
    when 'AOFE'
      AOFEEncounter
    else
      Encounter
    end    
  end
end