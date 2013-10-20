class Room < ActiveRecord::Base
    validates :number, :active, :presence => true
end
