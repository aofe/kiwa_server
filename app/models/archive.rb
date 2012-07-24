class Archive < ActiveRecord::Base
  include UncertainDate

  belongs_to :institution
end
