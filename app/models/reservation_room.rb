class ReservationRoom < ActiveRecord::Base
    belongs_to :reservation
    belongs_to :reservation_item, polymorphic: true
    # validates :reservation_id, presence: { message: "reservation_id no puede ser vacio" }
    validates :reservation_item_id, :reservation_item_type, :since, :until, :amount, presence: true #{ message: "sarasa" }
end
