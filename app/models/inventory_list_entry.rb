class InventoryListEntry < ActiveRecord::Base

  belongs_to :inventory  
  has_many_comments

  scope :search, lambda {|query| where('LOWER(id_tag) LIKE ? OR LOWER(description) LIKE ?', "%#{query.downcase}%", "%#{query.downcase}%") if query }
  scope :default_order, order(:inventory_id, :list_order)

  acts_as_relatable :artefact, :inventory_list_entry
  
  def display_name
    self.id_tag.presence || "Unidentified Entry"
  end
  
  # FIXME: Has many through isn't working through related_artefacts so do it manually
  def related_encounters
    related_artefacts.includes(:encounters).collect(&:encounters).flatten
  end
end
