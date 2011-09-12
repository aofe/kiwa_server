class Inventory < ActiveRecord::Base
  has_many :inventory_list_entries, :order => 'list_order ASC'
  
  def display_name
    self.short_title
  end
end
