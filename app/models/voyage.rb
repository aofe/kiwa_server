class Voyage < ActiveRecord::Base
  belongs_to :expedition
  has_many :crew_list_entries
  has_many :people, :through => :crew_list_entries

# relation stuff
  has_many :relations, :as => :source

  def artefacts
    Artefact.joins('JOIN relations on relations.target_id = artefacts.id AND relations.target_type = "Artefact"')
            .joins('JOIN voyages on voyages.id = relations.source_id AND relations.source_type = "Voyage"')
            .where(:voyages => {:id => self.id})
  end
  
end
