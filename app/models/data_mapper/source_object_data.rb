class SourceObjectData < ActiveRecord::Base
  
  establish_connection :kiwa2
  
  has_one :relation, :conditions => {:source_section_id => 3, :target_section_id => 2}, :foreign_key => :target_id
  has_one :project_object, :through => :relation
  
  belongs_to :institution
end