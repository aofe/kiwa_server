class Institution < ActiveRecord::Base
  has_many :artefacts
  has_many :inventories
  has_many :archives
  
  validates_presence_of :long_name, :short_name
  validates_uniqueness_of :long_name
end
