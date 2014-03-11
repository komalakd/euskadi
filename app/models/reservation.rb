class Reservation < ActiveRecord::Base
  belongs_to :passenger
  belongs_to :enterprise
  has_many :reservation_rooms
  has_many :payments
  validates :passenger_id, :amount, presence: true
  validates_presence_of :reservation_rooms, { message: 'Debe seleccionar al menos una.' }
  before_save :validate_dates_chronology, :validate_superpositions

  def validate_dates_chronology
    invalid_rrs = self.reservation_rooms.select{ |rr| rr.validate_dates_chronology }
    if invalid_rrs.size != 0

      denominations = invalid_rrs.collect{ |rr| rr.reservation_item.id }.join( ', ' ) # FIXME - id -> denomination

      self.errors[:base] << "Las fechas de la/s habitacion/es #{denominations} no son correctas."
      return false
    end
  end

  def validate_superpositions
    invalid_rrs = self.reservation_rooms.select{ |rr| rr.validate_superposition }
    if invalid_rrs.size != 0

      denominations = invalid_rrs.collect{ |rr| rr.reservation_item.id }.join( ', ' ) # FIXME - id -> denomination

      self.errors[:base] << "La/s habitacion/es #{denominations} ya han sido reservadas."
      return false
    end
  end

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


  def total_payment()
    total = 0
    self.payments.each{ |p| total += p.amount }
    return total
  end

end
