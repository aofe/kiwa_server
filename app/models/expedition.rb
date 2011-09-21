class Expedition < ActiveRecord::Base
  acts_as_relatable :encounter
  
  has_one :person_expedition
  has_one :principle_explorer, :through => :person_expedition, :class_name => 'Person', :source => 'person'

  has_many :voyages  
  has_many :crew_list_entries, :through => :voyages
  has_many :people, :through => :crew_list_entries
  
  scope :search, lambda {|query| where('LOWER(title) LIKE ?', "%#{query.downcase}%") if query }
  scope :default_order, order(:title)
  
  def name
    self.title
  end
  
  def display_name
    name
  end
end