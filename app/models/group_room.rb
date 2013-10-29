class GroupRoom < ActiveRecord::Base
    belongs_to :room
    belongs_to :group
    validates :room_id, :group_id, presence: true
end