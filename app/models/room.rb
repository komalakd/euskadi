class Room < ActiveRecord::Base
    belongs_to :room_type
    validates :number, :room_type_id, :presence => true
    validates :active, :inclusion => {:in => [true, false]}
end
