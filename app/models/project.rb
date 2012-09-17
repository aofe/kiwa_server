class Project < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user
  has_many :project_items
  has_many :comments, :as => :commentable

  scope :public, where(:public => true)

  validates :name, :uniqueness => {:scope => :user_id}, :presence => true

  def items
    project_items.pluck(:item_type).uniq.collect do |type|
      type.constantize.find(project_items.where(:item_type => type).pluck(:id))
    end.flatten
  end

  def display_name
    self.name
  end

  def size
    project_items.size
  end

  def empty?
    project_items.none?
  end
end
