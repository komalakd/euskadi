class Passenger < ActiveRecord::Base
  validates       :address, :birthdate, :city, :civil_status, :country, :dni, :lastname, :name, :nationality, :proffesion, :presence => true
end
