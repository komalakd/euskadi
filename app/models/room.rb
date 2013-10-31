class Room < ActiveRecord::Base
    belongs_to :room_type
    belongs_to :group
    has_many :reservations, as: :reservation_item
    validates :number, :active, :room_type_id, :group_id, presence: true
    validates :active, inclusion: { in: [true, false] }
end
