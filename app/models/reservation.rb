class Reservation < ActiveRecord::Base
    belongs_to :passenger
    belongs_to :enterprise
    has_many :reservation_rooms
    validates :number, :room_type_id, presence: true
end
