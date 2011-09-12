class Card < ActiveRecord::Base
  belongs_to :institution

  has_many :media_items

  acts_as_relatable :artefact
  
  scope :search, lambda {|query| where('LOWER(id_tag) LIKE ? OR LOWER(inscription) LIKE ?', "%#{query}%", "%#{query}%") if query }
end
