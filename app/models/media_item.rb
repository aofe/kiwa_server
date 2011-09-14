class MediaItem < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  
  validates_uniqueness_of :display_order, :scope => [:attachable_id, :attachable_type]
  
	def thumbnail_url(height)
	  self.source_url + "/#{height}/"
	end
end
