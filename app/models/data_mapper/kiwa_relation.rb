class KiwaRelation < ActiveRecord::Base
  
  set_table_name 'relations'
  establish_connection :kiwa2
  
  belongs_to :project_object, :foreign_key => :source_id
  belongs_to :source_object_data, :foreign_key => :target_id

end