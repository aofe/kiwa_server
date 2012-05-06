class Voyage < ActiveRecord::Base
  include UncertainDate
  include KIWAGeocodable
  
  belongs_to :expedition
  has_many :crew_list_entries
  has_many :people, :through => :crew_list_entries

  acts_as_relatable :encounter

  after_save :geocode_locations
  
  def display_name
    output = self.ship_name.dup
    output << " (#{start_date.to_formatted_s(:long_ordinal)})" if start_date
    return output
  end
  
  def geocode_locations
    geocode_field(:place_departed)
    geocode_field(:place_returned)
  end  

  # GLINT
  acts_as_searchable :default => :full_text

  has_facet :full_text, :type => :full_text, :param => 'contains', :phrases => {:ship_name => 2}

  has_facet :ship_name
  has_facet :ship_other_name
  has_facet :start_date, :attribute_type => :date
  has_facet :end_date, :attribute_type => :date
  has_facet :place_departed
  has_facet :place_returned
end