class Encounter < ActiveRecord::Base
  belongs_to :artefact

  has_many :media_items, :as => :attachable

  acts_as_relatable :voyage, :expedition
  
  validates_presence_of :accession_number, :encounter_type
  
  scope :search, lambda {|query| where('LOWER(name) LIKE ?', "%#{query}%") }
  
  # Other enounters with the same artefact
  def other_encounters
    artefact.encounters.where('encounters.id != ?', self.id)
  end
  
  def display_name
    "#{self.name} - #{self.accession_number}"
  end
end