class Person < ActiveRecord::Base
  include UncertainDate
  
  has_many :events
  
  has_many :person_expeditions
  has_many :expeditions_as_principle_explorer, :through => :person_expeditions, :class_name => 'Expedition'

  has_many :crew_list_entries
  has_many :voyages, :through => :crew_list_entries
  has_many :expeditions, :through => :voyages
  
  scope :default_order, order(:last_name, :first_name)
  
  def name
    output = []
    output << first_name
    output << "(#{other_name})" if other_name.present?
    output << last_name
    output.join(' ').strip # strip because some people have leading whitespace in their names
  end

  def sort_name
    output = []
    output << last_name
    output << ", " if first_name.present? || other_name.present?
    output << first_name
    output << "(#{other_name})" if other_name.present?
    output.join(' ').strip # strip because some people have leading whitespace in their names
  end
  alias :display_name :sort_name

  # GLINT
  acts_as_searchable :default => :full_text

  has_facet :full_text, :type => :full_text, :param => 'contains', :phrases => {:sort_name => 2}

  has_facet :name, :attribute_type => :string
  has_facet :sort_name, :attribute_type => :string, :param => 'name'
  has_facet :first_name
  has_facet :last_name
  has_facet :other_name
  has_facet :birth_date, :attribute_type => :date
  has_facet :death_date, :attribute_type => :date
  has_facet :background
  has_facet :education
  has_facet :character_reference
  has_facet :career
  has_facet :network
end
