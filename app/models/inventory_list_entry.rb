class InventoryListEntry < ActiveRecord::Base
  acts_as_relatable :artefact, :inventory_list_entry

  belongs_to :inventory
end
