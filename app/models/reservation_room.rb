class ReservationRoom < ActiveRecord::Base
    belongs_to :reservation
    belongs_to :reservation_item, polymorphic: true
end
