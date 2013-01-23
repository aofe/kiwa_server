class Encounter < ActiveRecord::Base
  include KIWAGeocodable
  
  belongs_to :artefact
  has_one :institution, :through => :artefact
  has_many :media_items, :as => :attachable
  has_one :primary_media_item, :as => :attachable, :class_name => 'MediaItem', :conditions => {:display_order => 1}
  has_many :comments, :as => :commentable
  has_many :notes, :as => :notable
  has_many :project_items, :as => :item
  has_many :projects, :through => :project_items

  acts_as_relatable :voyage, :expedition, :location
  
#  validates_presence_of :accession_number, :encounter_type
  
  scope :with_images, joins(:media_items).where(:media_items => {:display_order => 1})
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
  
  def to_s
    "#{self.name} - #{self.accession_number}"
  end
  
  def events
    artefact.events
  end
  
  def geocode_locations
    geocode_field(:place_of_origin)
  end
end