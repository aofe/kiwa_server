class CrewListEntry < ActiveRecord::Base
  belongs_to :person
  belongs_to :voyage
end
