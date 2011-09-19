class Card < ActiveRecord::Base
  belongs_to :institution

  has_many :media_items
  has_one :primary_media_item, :as => :attachable, :class_name => 'MediaItem', :conditions => {:display_order => 1}

  acts_as_relatable :artefact
  
  scope :search, lambda {|query| where('LOWER(id_tag) LIKE ? OR LOWER(inscription) LIKE ?', "%#{query.downcase}%", "%#{query.downcase}%") if query }
end
