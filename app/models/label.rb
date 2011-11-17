class Label < ActiveRecord::Base
  belongs_to :institution

  has_many :media_items, :as => :attachable
  has_one :primary_media_item, :as => :attachable, :class_name => 'MediaItem', :conditions => {:display_order => 1}

  acts_as_relatable :artefact
  
  scope :search, lambda {|query| where('LOWER(id_tag) LIKE ? OR LOWER(inscription) LIKE ?', "%#{query.downcase}%", "%#{query.downcase}%") if query }
  scope :default_order, order(:id)
  
  def display_name
    self.id_tag.presence || self.inscription
  end
  
  # FIXME: Has many through isn't working through related_artefacts so do it manually
  def related_encounters
    related_artefacts.includes(:encounters).collect(&:encounters).flatten
  end  
end
