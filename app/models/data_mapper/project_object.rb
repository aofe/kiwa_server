class ProjectObject < ActiveRecord::Base
  
  establish_connection :kiwa2
  set_table_name 'objects'
  
  has_one :relation, :conditions => {:source_section_id => 3, :target_section_id => 2}, :foreign_key => :source_id
  has_one :source_object_data, :through => :relation, :source => :target
  
  belongs_to :source_institution
end