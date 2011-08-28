class Card < ActiveRecord::Base
  belongs_to :institution

  has_many :media_items

  acts_as_relatable :artefact
end
