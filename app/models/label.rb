class Label < ActiveRecord::Base
  has_many :media_items, :as => :attachable

  acts_as_relatable :artefact
  
  scope :search, lambda {|query| where('LOWER(id_tag) LIKE ? OR LOWER(inscription) LIKE ?', "%#{query}%", "%#{query}%") if query }
  
  def display_name
    self.id_tag.presence || self.inscription
  end
  
  # FIXME: Has many through isn't working through related_artefacts so do it manually
  def related_encounters
    related_artefacts.includes(:encounters).collect(&:encounters).flatten
  end  
end
