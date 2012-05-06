class Location < ActiveRecord::Base
  acts_as_dag
  acts_as_relatable :encounter, :voyage

  geocoded_by :name
  after_validation :geocode
  
  def display_name
    self.name
  end
  
  # Returns encounters for those related to descendant locations
  def related_with_descendants(type)
    klass = type.to_s.classify
    relationships = ActsAsRelatable::Relationship.where(:relator_id => descendants.collect(&:id), :relator_type => 'Location', :related_type => klass)
    klass.constantize.where(:id => relationships.collect(&:related_id))
  end

  # GLINT
  acts_as_searchable :default => :full_text

  has_facet :full_text, :type => :full_text, :param => 'contains'

  has_facet :name
end
