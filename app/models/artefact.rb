class Artefact < ActiveRecord::Base
#  acts_as_relatable :inventory_list_entries, :cards, :expeditions, :voyages

  belongs_to :institution
  has_many :events
  has_many :encounters  
end
