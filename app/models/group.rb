class Group < ActiveRecord::Base
    has_many :rooms
    has_many :reservations, as: :reservation_item
    validates :name, presence: true
end

public
def common_denomination
    self.name.to_s
end