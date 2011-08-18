class InventoryListEntry < ActiveRecord::Base
#  acts_as_relatable :artefacts
  belongs_to :inventory
end
