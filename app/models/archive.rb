class Archive < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :institution
end
