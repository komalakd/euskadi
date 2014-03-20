class User < ActiveRecord::Base
  validates :login, :lastname, :name, :email, presence: true
  before_save :create_remember_token
  validates_uniqueness_of :login
  validates_uniqueness_of :email

  has_secure_password
  validates_presence_of :password, :on => :create


  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
