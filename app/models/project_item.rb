class ProjectItem < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :item, :polymorphic => true
  belongs_to :project

  validates_uniqueness_of :project_id, :scope => :item_id

  delegate :display_name, :to => :item

  def primary_media_item
    item.primary_media_item if item.respond_to? :primary_media_item
  end
end