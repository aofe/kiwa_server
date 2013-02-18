class MediaItem < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  
  validates_uniqueness_of :display_order, :scope => [:attachable_id, :attachable_type]
  
	def source_url
		if self[:source_url].include? "aofe.maa.cam.ac.uk" 
			self[:source_url] + "kiwaserver/"
		else
			self[:source_url]
		end
	end

	def thumbnail_url(height)
		self.source_url + "#{height}/"
	end
end
