class Passenger < ActiveRecord::Base
  has_many :reservations
  validates :dni, :lastname, :name, :phone_number, presence: true
end
