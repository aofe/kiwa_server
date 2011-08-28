class Label < ActiveRecord::Base
  has_many :media_items, :as => :attachable

  acts_as_relatable :artefact
end
