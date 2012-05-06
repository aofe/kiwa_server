class Encounter < ActiveRecord::Base
  include KIWAGeocodable
  
  belongs_to :artefact
  has_one :institution, :through => :artefact

  has_many :media_items, :as => :attachable
  has_one :primary_media_item, :as => :attachable, :class_name => 'MediaItem', :conditions => {:display_order => 1}

  acts_as_relatable :voyage, :expedition, :location
  
#  validates_presence_of :accession_number, :encounter_type
  
  scope :with_images, joins(:media_items).where(:media_items => {:display_order => 1})
  scope :default_order, order(:name)
  scope :type, lambda {|type| where(:type => "#{type}_encounter".classify)}
  
  after_save :geocode_locations
  
  # Other enounters with the same artefact
  def other_encounters
    artefact.encounters.where('encounters.id != ?', self.id)
  end
  
  def other_source_encounters
    other_encounters.type('source')
  end
  
  def other_aofe_encounters
    other_encounters.type('aofe')
  end
  
  def display_name
    "#{self.name} - #{self.accession_number}"
  end
  
  def events
    artefact.events
  end
  
  def geocode_locations
    geocode_field(:place_of_origin)
  end

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
end