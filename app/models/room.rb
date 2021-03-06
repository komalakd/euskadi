class Room < ActiveRecord::Base
    belongs_to :room_type
    belongs_to :group
    belongs_to :page
    has_many :reservations, as: :reservation_item
    validates :number, :room_type_id, presence: true
    validates :active, inclusion: { in: [true, false] }
end

public
def denomination
    return self.number.to_s
end