class DigitalReference < ActiveRecord::Base
  include UncertainDate

  belongs_to :institution
  
  self.table_name = 'reference_digital'
end
