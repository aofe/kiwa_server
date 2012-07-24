class TextReference < ActiveRecord::Base
  include UncertainDate
  self.table_name = 'reference_text'
end
