class Note < ActiveRecord::Base
  belongs_to :noteable, :polymorphic => true

  before_validation_on_create :set_note_order
  validates_presence_of :note_text, :note_order
  
  private
  
  # Puts this note last in the order of notes on the noteable
  def set_note_order
    self.note_order = noteable.notes.maximum(:note_order) + 1
  end
  
end