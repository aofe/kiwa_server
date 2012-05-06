class Label < ActiveRecord::Base
  belongs_to :institution

  has_many :media_items, :as => :attachable
  has_one :primary_media_item, :as => :attachable, :class_name => 'MediaItem', :conditions => {:display_order => 1}

  acts_as_relatable :artefact
    
  def display_name
    self.id_tag.presence || self.inscription
  end
  
  # FIXME: Has many through isn't working through related_artefacts so do it manually
  def related_encounters
    related_artefacts.includes(:encounters).collect(&:encounters).flatten
  end

  # GLINT
  acts_as_searchable :default => :full_text

  has_facet :full_text, :type => :full_text, :param => 'contains', :phrases => {:id_tag => 2}

  has_facet :id_tag
  has_facet :institution, :accessor_method => :long_name
  has_facet :inscription
  has_facet :attachment_method
  has_facet :attachment_location
  has_facet :related_encounters, :accessor_method => :display_name, :multiple => true, :attribute_type => :string, :param => :encounter
end
