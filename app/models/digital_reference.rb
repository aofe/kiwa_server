class DigitalReference < ActiveRecord::Base
  include UncertainDate

  self.table_name = 'reference_digital'
end
