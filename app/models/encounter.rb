class Encounter < ActiveRecord::Base
  belongs_to :artefact

  has_many :media_items, :as => :attachable
  has_one :primary_media_item, :as => :attachable, :class_name => 'MediaItem', :conditions => {:display_order => 1}

  acts_as_relatable :voyage, :expedition
  
  validates_presence_of :accession_number, :encounter_type
  
  scope :search, lambda {|query| where('LOWER(name) LIKE ?', "%#{query}%") if query }
  scope :with_images, joins(:media_items).where(:media_items => {:display_order => 1})
  
  # Other enounters with the same artefact
  def other_encounters
    artefact.encounters.where('encounters.id != ?', self.id)
  end
  
  def display_name
    "#{self.name} - #{self.accession_number}"
  end
  
  def events
    artefact.events
  end
end