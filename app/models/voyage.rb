class Voyage < ActiveRecord::Base
  belongs_to :expedition
  has_many :crew_list_entries
  has_many :people, :through => :crew_list_entries

  acts_as_relatable :encounter

  scope :search, lambda {|query| joins(:expedition).where('LOWER(expeditions.title) LIKE ? OR LOWER(ship_name) LIKE ?', "%#{query}%", "%#{query}%") if query }
  
  def display_name
    output = self.ship_name
    output << " (#{start_date})" if start_date
    return output
  end
  
  def start_date(params = {})
    parse_date(start_year, start_month, start_day, params)
  end

  def end_date(params = {})
    parse_date(end_year, end_month, end_day, params)
  end

  def date_precision
    if end_year && end_month && end_day && start_year && start_month && start_day
      :day
    elsif end_year && end_month && start_year && start_month
      :month
    elsif end_year && start_year
      :year
    else
      :none
    end
  end    
  
  private
  
  def parse_date(year, month, day, params = {})
    return nil if year.blank? || year == 0
    date = [year]
    date << month unless month.blank? or month == 0
    date << day unless day.blank? or day == 0
    date = date.join('/')
    Date.parse(date)
  rescue ArgumentError
    return nil
  end  
end