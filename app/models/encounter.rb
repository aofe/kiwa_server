class Encounter < ActiveRecord::Base
  belongs_to :artefact

  has_many :media_items
  has_many :labels
  has_many :researchers # Automatically related by parsing the text content of the encounter
  
  validates_presence_of :accession_number, :encounter_type
  
end