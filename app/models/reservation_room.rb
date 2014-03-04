class ReservationRoom < ActiveRecord::Base
    belongs_to :reservation
    belongs_to :reservation_item, polymorphic: true
    # validates :reservation_id, presence: { message: "reservation_id no puede ser vacio" }
    validates :reservation_item_id, :reservation_item_type, :since, :until, :amount, presence: true #{ message: "sarasa" }

    def validate_superposition
        other_rr = ReservationRoom.where( 
            "reservation_item_type = ? AND reservation_item_id = ? AND since < ? AND until > ?", 
            self.reservation_item_type, self.reservation_item_id, self.until, self.since 
        ).first
        logger.debug "---------validate_superposition------------"
        logger.debug other_rr.inspect
        logger.debug other_rr.nil?
        return other_rr.nil? ? false : true
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
