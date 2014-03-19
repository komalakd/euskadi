class Enterprise < ActiveRecord::Base
    has_many :reservations
    validates :cuit, :name, :address, presence: true
    validates_uniqueness_of :cuit
end
