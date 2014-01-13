class RoomType < ActiveRecord::Base
    has_many :rooms
    validates :denomination, :amount, :presence => true
end
