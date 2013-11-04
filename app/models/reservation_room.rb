class ReservationRoom < ActiveRecord::Base
    belongs_to :reservation
    belongs_to :reservation_item, polymorphic: true
    validates :reservation_id, :reservation_item_id, :reservation_item_type, :since, :until, presence: { message: "sarasa" }
end
