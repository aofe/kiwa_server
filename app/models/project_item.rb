class ProjectItem < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :item, :polymorphic => true
  belongs_to :project

  validates_uniqueness_of :project_id, :scope => :item_id

  delegate :display_name, :to => :item

  def primary_media_item
    item.primary_media_item if item.respond_to? :primary_media_item
  end

  # GLINT
  
  # require 'item'
  require 'project_item_search'
  acts_as_searchable :default => :full_text
  
  has_facet :full_text, :type => :full_text, :param => 'contains'
  has_facet :project
  has_facet :note
  has_facet :item_type, :param => 'type'
  has_facet :display_name, :param => 'name', :attribute_type => :string
  
  # inherits_facets_from :item
  reindex_on_facet_changes :only => :note # Don't reindex on holding institution update because changes to the item view count will trigger reindexes
end