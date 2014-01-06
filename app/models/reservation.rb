class Reservation < ActiveRecord::Base
  belongs_to :passenger
  belongs_to :enterprise
  has_many :reservation_rooms
  validates :passenger_id, :amount, presence: true
  validates_presence_of :reservation_rooms, { message: 'Debe seleccionar al menos una.' }

  def update_instance(items) # { rooms: [], groups: [] }

    logger.debug( "-------------------------------ITEMS--------------------------------\n" )
    logger.debug( items )

    new_rooms  = items[:rooms]
    new_groups = items[:groups]

    Room.all.each do |room|

      old = self.reservation_rooms.where( reservation_item: room ).first
      new = new_rooms.find { |rr| rr.reservation_item_id == room.id } 

      # logger.debug( "-------------------------------" )
      # logger.debug( old.inspect )
      # logger.debug( new.inspect )

      if( old && new ) # update
        old.update_attributes( since: new.since, until: new.until, amount: new.amount )
      elsif( old && !new ) #destroy
        old.destroy
      elsif( !old && new ) # create 
        self.reservation_rooms.build( 
          since: new.since,
          until: new.until,
          amount: new.amount,
          reservation_item: new.reservation_item
        )
      end

    end

    Group.all.each do |group|

      old = self.reservation_rooms.where( reservation_item: group ).first
      new = new_groups.find { |rr| rr.reservation_item_id == group.id } 

      # logger.debug( "-------------------------------" )
      # logger.debug( old.inspect )
      # logger.debug( new.inspect )

      if( old && new ) # update
        old.update_attributes( since: new.since, until: new.until, amount: new.amount )
      elsif( old && !new ) #destroy
        old.destroy
      elsif( !old && new ) # create 
        self.reservation_rooms.build( 
          since: new.since,
          until: new.until,
          amount: new.amount,
          reservation_item: new.reservation_item
        )
      end

    end



  end

end
