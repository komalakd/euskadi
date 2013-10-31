class Passenger < ActiveRecord::Base
  has_many :reservations
  validates :address, :birthdate, :city, :country, :dni, :lastname, :name, :nationality, presence: true
end
