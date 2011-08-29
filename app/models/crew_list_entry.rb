class CrewListEntry < ActiveRecord::Base
  belongs_to :person
  belongs_to :voyage
  
  has_one :expedition, :through => :voyage
end
