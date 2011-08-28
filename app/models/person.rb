class Person < ActiveRecord::Base
  has_many :events
  
  has_many :person_expeditions
  has_many :expeditions_as_principle_explorer, :through => :person_expeditions

  has_many :crew_list_entries
  has_many :voyages, :through => :crew_list_entries
  has_many :expeditions, :through => :voyages
end
