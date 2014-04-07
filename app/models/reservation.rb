class Reservation < ActiveRecord::Base
  belongs_to :passenger
  belongs_to :enterprise
  has_many :reservation_rooms
  has_many :payments
  
  validates :passenger_id, :amount, presence: true
  # validates_presence_of :reservation_rooms
  
  after_save :save_reservation_rooms
  


  def guardar(items) # { rooms: [], groups: [] }

    return false unless self.valid?

    new_rooms  = items[:rooms]
    new_groups = items[:groups]

    to_validate = Array.new()
    count = 0

    Room.all.each do |room|
      old = self.reservation_rooms.where( reservation_item: room ).first
      new = new_rooms.find { |rr| rr.reservation_item_id == room.id } 

      if( old && new ) # update
        old.assign_attributes( 
          since: new.since, 
          until: new.until, 
          amount: new.amount 
        )
        count += 1
        to_validate.push( old )
      elsif( old && !new ) #destroy
        old.mark_for_destruction
      elsif( !old && new ) # create 
        self.reservation_rooms.build(
          since: new.since,
          until: new.until,
          amount: new.amount,
          reservation_item: new.reservation_item
        )
        count += 1
        to_validate.push( new )
      end
    end

    Group.all.each do |group|
      old = self.reservation_rooms.where( reservation_item: group ).first
      new = new_groups.find { |rr| rr.reservation_item_id == group.id } 

      if( old && new ) # update
        old.assign_attributes( 
          since: new.since, 
          until: new.until, 
          amount: new.amount 
        )
        count += 1
        to_validate.push( old )
      elsif( old && !new ) #destroy
        old.mark_for_destruction
      elsif( !old && new ) # create 
        self.reservation_rooms.build( 
          since: new.since,
          until: new.until,
          amount: new.amount,
          reservation_item: new.reservation_item
        )
        count += 1
        to_validate.push( new )
      end
    end


    if count == 0
      self.errors[:base] << "Debe seleccionar al menos una habitacion."
      return false
    end

    to_validate.each do |rr|
      if !rr.valid?
        # logger.debug "---------------------------RR NOT VALID".inspect
        # logger.debug rr.errors.full_messages
        rr.errors.full_messages.each do |msg|
          self.errors[:base] << msg
        end
        return false
      end
    end

    return self.save

  end



  def save_reservation_rooms
    logger.debug '---------------------------save_reservation_rooms--------------------------'
    self.reservation_rooms.each do |rr| 
      logger.debug rr.inspect
      rr.save!
    end
  end


  def total_payment()
    total = 0
    self.payments.each{ |p| total += p.amount }
    return total
  end

end
