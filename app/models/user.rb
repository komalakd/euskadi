class User < ActiveRecord::Base
  validates :login, :lastname, :name, :email, :password, presence: true
  # before_save { generate_token(:remember_token) }

end
