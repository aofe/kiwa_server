class Relation < ActiveRecord::Base
  
  belongs_to :source, :polymorphic => true
  belongs_to :target, :polymorphic => true

end