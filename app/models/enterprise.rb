class Enterprise < ActiveRecord::Base
    has_many :reservations
    validates :cuil, :name, presence: true
end
