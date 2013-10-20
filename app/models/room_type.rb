class RoomType < ActiveRecord::Base
    validates :denomination, :amount, :presence => true
end
