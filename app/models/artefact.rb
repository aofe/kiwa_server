class Artefact < ActiveRecord::Base
  belongs_to :institution

  has_many :events
  has_many :encounters

  acts_as_relatable :inventory_list_entry, :card, :label
end
