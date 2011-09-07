class Expedition < ActiveRecord::Base
  acts_as_relatable :encounter
  
  has_one :person_expeditions
  has_one :principle_explorer, :through => :person_expeditions, :class_name => 'Person'

  has_many :voyages  
  has_many :crew_list_entries, :through => :voyages
  has_many :people, :through => :crew_list_entries
  
  def name
    self.title
  end
  
  def display_name
    name
  end
end