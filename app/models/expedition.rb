class Expedition < ActiveRecord::Base
  acts_as_relatable :artefacts
  
  has_one :principle_explorer_entry
  has_one :principle_explorer, :through => :principle_explorer_entry

  has_many :voyages  
  has_many :crew_list_entries, :through => :voyages
  has_many :people, :through => :crew_list_entries
end