class Voyage < ActiveRecord::Base
  include UncertainDate
  include KIWAGeocodable
  
  belongs_to :expedition
  has_many :crew_list_entries
  has_many :people, :through => :crew_list_entries

  acts_as_relatable :encounter

  scope :search, lambda {|query| where('LOWER(ship_name) LIKE ?', "%#{query.downcase}%") if query }
  scope :default_order, order(:ship_name)

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
end