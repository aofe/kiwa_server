class Expedition < ActiveRecord::Base
  acts_as_relatable :encounter
  
  has_one :person_expedition
  has_one :principle_explorer, :through => :person_expedition, :class_name => 'Person', :source => 'person'
  has_many :voyages  
  has_many :crew_list_entries, :through => :voyages
  has_many :people, :through => :crew_list_entries
  has_many :comments, :as => :commentable
  
  def name
    self.title
  end
  
  def display_name
    name
  end

  # GLINT
  acts_as_searchable :default => :full_text

  has_facet :full_text, :type => :full_text, :param => 'contains', :phrases => {:title => 2}

  has_facet :title
  has_facet :commissioned
end