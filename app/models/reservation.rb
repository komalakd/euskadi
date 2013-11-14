class Reservation < ActiveRecord::Base
    belongs_to :passenger
    belongs_to :enterprise
    has_many :reservation_rooms
    validates :passenger_id, :amount, presence: true

    # private
    #     #params [ reservation_item ]
    #     def update_instance(reservation_rooms)

    #         # current reservation_items
    #         current_rr = ReservationRoom.where( reservation: self )

    #         new_ri     = new_rr.collect{ |rr| rr.reservation_item }
    #         current_ri = new_rr.collect{ |rr| rr.reservation_item }

    #         create  = new_ri - current_ri
    #         update  = new_ri & current_ri
    #         destroy = current_ri - new_ri

    #         create.each do |rr|
    #             self.reservation_rooms.build(
    #                 since: Date.strptime(rr.since, "%d/%m/%Y"),
    #                 until: Date.strptime(rr.until, "%d/%m/%Y"),
    #                 reservation_item: rr.reservation_item
    #             )
    #         end




    #         new_reservation_rooms = []
    #         # new reservation_items
    #         reservation_rooms.each do |rr|
                
    #             obj = ReservationRoom.where( reservation: self, reservation_item: rr.reservation_item )
    #             # si no existe lo creo
    #             if ( !obj ){
    #                 self.reservation_rooms.build(
    #                     since: Date.strptime(rr.since, "%d/%m/%Y"),
    #                     until: Date.strptime(rr.until, "%d/%m/%Y"),
    #                     reservation_item: rr.reservation_item
    #                 )

    #             # si existe en base y no viene como parametro lo borro
    #             }elsif( current_rr.find( reservation_item: rr.reservation_item ) ){
    #                 self.reservation_items.where( reservation_item: rr.reservation_item ).destroy

    #             # si existe en base y viene como parametro
    #             }else{

    #             }


    #         end

    #     end

end
