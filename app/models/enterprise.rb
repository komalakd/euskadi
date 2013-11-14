class Enterprise < ActiveRecord::Base
    has_many :reservations
    validates :cuit, :name, :address, presence: true
end
