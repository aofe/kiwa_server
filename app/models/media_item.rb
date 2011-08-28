class MediaItem < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  
	def thumbnail_url(height)
	  self.source_url + "/#{height}/"
	end

end
