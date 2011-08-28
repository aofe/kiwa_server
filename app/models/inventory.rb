class Inventory < ActiveRecord::Base
  has_many :inventory_list_entries
end
