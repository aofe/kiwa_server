class Inventory < ActiveRecord::Base
  belongs_to :institution  
  has_many :inventory_list_entries

  # acts_as_relatable relation
  has_many :inventory_list_entry_relations, :through => :inventory_list_entries
  has_many :artefacts, :through => :inventory_list_entry_relations
end
