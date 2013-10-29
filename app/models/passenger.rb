class Passenger < ActiveRecord::Base
  has_many :reservations
  validates :address, :birthdate, :city, :civil_status, :country, :dni, :lastname, :name, :nationality, :proffesion, presence: true
end
