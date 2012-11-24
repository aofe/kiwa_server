class User < ActiveRecord::Base
  acts_as_crier

  has_many :projects
 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable, :invitable
  attr_accessible :name, :email, :password, :password_confirmation # Setup accessible (or protected) attributes for your model
  validates_presence_of :name, :email, :password


  def to_s
    self.name.presence || self.email
  end
end
