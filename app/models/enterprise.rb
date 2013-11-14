class Enterprise < ActiveRecord::Base
    has_many :reservations
    validates :cuit, :name, presence: true
end
