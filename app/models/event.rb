class Event < ActiveRecord::Base
  include UncertainDate
  belongs_to :artefact
  belongs_to :person  
end
