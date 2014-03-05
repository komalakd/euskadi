class RoomPassenger < ActiveRecord::Base
  belongs_to :reservation_room
  belongs_to :passenger

  validates :reservation_room_id, :passenger_id, presence: true

end
