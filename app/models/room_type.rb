class RoomType < ActiveRecord::Base
    has_many :rooms
    validates :denomination, :presence => true
end
