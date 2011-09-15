class Voyage < ActiveRecord::Base
  include UncertainDate
  
  belongs_to :expedition
  has_many :crew_list_entries
  has_many :people, :through => :crew_list_entries

  acts_as_relatable :encounter

  scope :search, lambda {|query| where('LOWER(ship_name) LIKE ?', "%#{query}%") if query }
  
  def display_name
    output = self.ship_name.dup
    output << " (#{start_date.to_formatted_s(:long_ordinal)})" if start_date
    return output
  end
end