class ReservationRoom < ActiveRecord::Base
    belongs_to :reservation
    belongs_to :reservation_item, polymorphic: true
    has_many :room_passengers
    has_many :passengers, through: :room_passengers

    validates :reservation_item_id, :reservation_item_type, :since, :until, :amount, presence: true
    validates_numericality_of :amount, greater_than: 0

    validate :validate_superposition, :validate_dates_chronology

    # devuelve true cuando se superpone con otra
    def validate_superposition

        self_condition = "AND id != #{self.id}" if ( self.id  ) # excluir de la consulta
        other_rr = ReservationRoom.where( 
            "reservation_item_type = ? AND reservation_item_id = ? AND since < ? AND until > ? #{self_condition}", 
            self.reservation_item_type, self.reservation_item_id, self.until, self.since 
        ).first

        return true if other_rr.nil?

        denomination = self.reservation_item_type == 'Room' ? self.reservation_item.number : self.reservation_item.name

        self.errors[:base] << "La habitacion #{denomination} ya ha sido reservada."
        return false
    end

    # devuelve true cuando la fecha desde no es anterior a la fecha hasta
    def validate_dates_chronology
      return true if self.since < self.until
      
      denomination = self.reservation_item_type == 'Room' ? self.reservation_item.number : self.reservation_item.name

      self.errors[:base] << "Las fechas de la habitacion #{denomination} no son correctas."
      return false
    end

    # Retorna todas las habitaciones reservadas en un periodo de tiempo.
    def self.Get_rooms(args)

        return ReservationRoom.where( "since >= ? AND until <= ?", args.since, args.until )

        # return ReservationRoom.all.each{ |rr| rr.reservation_item }
    end

    # Retorna el/los ids de las habitaciones asociadas
    def get_rooms
        if self.reservation_item_type == 'Room'
            return [ self.reservation_item_id ]
        else
            return self.reservation_item.rooms.collect{ |room| room.id }
        end
    end

end
