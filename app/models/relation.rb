# This class serves as a representation of the relationship between to models
# This behavioural mechanics of that relationship is handled by the acts_as_relatable gem
class Relation < ActiveRecord::Base  
  belongs_to :source, :polymorphic => true
  belongs_to :target, :polymorphic => true

  has_many :notes, :as => :noteable

  validates_presence_of :source_id, :source_type, :target_id, :target_type
  after_save :relate_endpoints
    
  # Uses the acts_as_relatable gem to relate the source and target together
  def relate_endpoints
    source.relates_to! target, true, self.rating
  end  
end