class User < ActiveRecord::Base
  validates :login, :lastname, :name, :email, :password, presence: true
  # has_secure_password
  before_save :create_remember_token


  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
