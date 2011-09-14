class Voyage < ActiveRecord::Base
  include UncertainDate
  
  belongs_to :expedition
  has_many :crew_list_entries
  has_many :people, :through => :crew_list_entries

  acts_as_relatable :encounter

  scope :search, lambda {|query| joins(:expedition).where('LOWER(expeditions.title) LIKE ? OR LOWER(ship_name) LIKE ?', "%#{query}%", "%#{query}%") if query }
  
  def display_name
    output = self.ship_name.dup
    output << " (#{start_date.to_formatted_s(:long_ordinal)})" if start_date
    return output
  end
end