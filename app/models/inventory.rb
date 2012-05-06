class Inventory < ActiveRecord::Base
  has_many :inventory_list_entries, :order => 'list_order ASC'
  
  def display_name
    self.short_title
  end

  def length
  	inventory_list_entries.count
  end

  # GLINT
  acts_as_searchable :default => :full_text

  has_facet :full_text, :type => :full_text, :param => 'contains', :phrases => {:short_title => 2}, :boost => {:description => 0.6}

  has_facet :short_title
  has_facet :long_title
  has_facet :description
  has_facet :source_reference
  has_facet :inventory_list_entries, :accessor_method => :description
end
