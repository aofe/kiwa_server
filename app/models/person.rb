class Person < ActiveRecord::Base
  has_many :events
  
  has_many :person_expeditions
  has_many :expeditions_as_principle_explorer, :through => :person_expeditions, :class_name => 'Expedition'

  has_many :crew_list_entries
  has_many :voyages, :through => :crew_list_entries
  has_many :expeditions, :through => :voyages
  
  scope :search, lambda {|query| where('LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?', "%#{query.downcase}%", "%#{query.downcase}%") if query }
  scope :default_order, order(:first_name, :last_name)
  
  def display_name
    output = []
    output << first_name
    output << "(#{other_name})" if other_name.present?
    output << last_name
    output.join(' ').strip # strip because some people have leading whitespace in their names
  end
end
