class Group < ActiveRecord::Base
    has_many :rooms
    has_many :reservations, as: :reservation_item
    validates :name, :amount, presence: true
    validates_numericality_of :amount, greater_than: 0
end

public
def denomination
    return self.group_id
end