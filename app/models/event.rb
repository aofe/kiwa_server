class Event < ActiveRecord::Base
  belongs_to :artefacts
  belongs_to :people
end
