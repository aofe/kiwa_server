class Person < ActiveRecord::Base
  has_many :events
  
  has_many :person_expeditions
  has_many :expeditions_as_principle_explorer, :through => :person_expeditions, :class_name => 'Expedition'

  has_many :crew_list_entries
  has_many :voyages, :through => :crew_list_entries
  has_many :expeditions, :through => :voyages
  
  def display_name
    output = []
    output << first_name
    output << "(#{other_name})" if other_name.present?
    output << last_name
    output.join(' ').strip # strip because some people have leading whitespace in their names
  end
end
