class InventoryListEntry < ActiveRecord::Base

  belongs_to :inventory  

  acts_as_relatable :artefact, :inventory_list_entry
  has_many :related_encounters, :through => :related_artefacts
  
  def display_name
    self.id_tag || self.description
  end
end
