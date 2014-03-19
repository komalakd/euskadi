class RoomType < ActiveRecord::Base
    has_many :rooms
    validates :denomination, :amount, :presence => true
    validates_numericality_of :amount, greater_than: 0
end
