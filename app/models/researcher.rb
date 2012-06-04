class Researcher < ActiveRecord::Base
  has_many :encounters

  def display_name
  	"#{self.first_name} #{self.last_name}"
  end
end
