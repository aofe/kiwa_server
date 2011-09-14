class PersonExpedition < ActiveRecord::Base
  belongs_to :person
  belongs_to :expedition  
end
