class StiEncounters < ActiveRecord::Migration
  def up
    Encounter.find_each do |encounter|
      case encounter.encounter_type
      when 'source'
        encounter.encounter_type = 'MAAEncounter'
      when 'aofe'
        encounter.encounter_type = 'AOEEncounter'
      end
      encounter.save!
    end
    rename_column :encounters, :encounter_type, :type
  end

  def down
    rename_column :encounters, :type, :encounter_type    
    Encounter.find_each do |encounter|
      case encounter.encounter_type
      when 'MAAEncounter'
        encounter.encounter_type = 'source'
      when 'AOEEncounter'
        encounter.encounter_type = 'aofe'
      end
      encounter.save!      
    end
    
  end
end
