class Inventory < ActiveRecord::Base
  has_many :inventory_list_entries, :order => 'list_order ASC'

  scope :search, lambda {|query| where('LOWER(short_title) LIKE ? OR LOWER(long_title) LIKE ? OR LOWER(description) LIKE ?', "%#{query.downcase}%", "%#{query.downcase}%", "%#{query.downcase}%") if query }
  scope :default_order, order(:short_title)
  
  def display_name
    self.short_title
  end
end
