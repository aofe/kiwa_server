class Person < ActiveRecord::Base
  has_many :events
  
  has_many :expeditions_as_principle_explorer, :through => :principle_explorer_entries
  has_many :principle_explorer_entries

  has_many :expeditions, :through => :voyages
  has_many :voyages, :through => :crew_list_entries
  has_many :crew_list_entries
end
