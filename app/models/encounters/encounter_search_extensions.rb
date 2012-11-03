module EncounterSearchExtensions
  def self.included(base)
    base.class_eval do      
      # GLINT
      acts_as_searchable :default => :full_text

      has_facet :full_text, :type => :full_text, :param => 'contains', :phrases => {:name => 2}, :boost => {:description => 0.6}

      has_facet :accession_number
      has_facet :name
      has_facet :type
      has_facet :place_of_origin, :param => :origin
      has_facet :indigenous_name
      has_facet :material
      has_facet :description
      has_facet :institution, :accessor_method => :long_name
    end
  end
end