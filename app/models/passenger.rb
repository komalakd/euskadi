class Passenger < ActiveRecord::Base
  has_many :reservations
  has_many :room_passengers
  has_many :reservation_rooms, through: :room_passengers
  validates :dni, :lastname, :name, :phone_number, presence: true
  validates_uniqueness_of :dni
  validates_numericality_of :dni, greater_than: 0
end
