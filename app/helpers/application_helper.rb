module ApplicationHelper

  # { id: 1, items: { id: 1, type: 'Room', since: DATE, until: DATE, amount: 10 } }
  def reservation_as_json(r)
    {
      id: r.id,
      passenger: r.passenger ? { id: r.passenger_id, dni: r.passenger.dni, passenger_denomination: r.passenger.name + ' ' + r.passenger.lastname + ' (' + r.passenger.dni + ')' } : nil,
      items: r.reservation_rooms.collect do |rr|
        {
          id: rr.reservation_item_id,
          type: rr.reservation_item_type,
          since: rr.since.strftime("%d/%m/%Y"),
          until: rr.until.strftime("%d/%m/%Y"),
          amount: rr.amount,
        }
      end
    }.to_json
  end

  # { 1: { group_id: 1 amount: 10 }, { }, ... }
  def rooms_as_json(rooms)
    hash = {}
    rooms.each do |r|
      hash[r.id] = {
        group_id: r.group_id,
        amount: r.amount
      }
    end
    return hash.to_json
  end

  # { 1: { rooms: [ 1, 2 ], amount: 10, { }, ... }
  def groups_as_json(groups)
    hash = {}
    groups.each do |g|
      hash[g.id] = {
        rooms: g.rooms.collect { |r| r.id },
        amount: g.amount
      }
    end
    return hash.to_json
  end

  # { 1: 10, 2: 20 }
  def room_types_as_json(room_types)
    hash = {}
    room_types.each do |rt|
      hash[rt.id] = {
        rooms: rt.rooms.collect{ |room| room.id },
        amount: rt.amount
      }
    end
    return hash.to_json
  end

  # { 1: 10, 2: 20 }
  def reservation_rooms_as_json(items)
    hash = {}
    items.each do |ri|
      dates = ( (ri.since)..(ri.until) ).collect{ |date| date.strftime("%Y_%m_%d") }
      hash[ri.id] = {
        reservation: ri.reservation_id,
        rooms: ri.get_rooms,
        dates: dates
      }
      @debugs << { hash: dates }
    end
    return hash.to_json
  end

  # [ { id: 4, dni: 12345678, full_name: 'pepe argento' ]
  def passengers_as_json(passengers)
    passengers.map{ |p| { passenger_id: p.id, dni: p.dni, passenger_denomination: p.name + ' ' + p.lastname + ' (' + p.dni + ')' } }.to_json
  end

  # [ { id: 4, dni: 12345678, full_name: 'pepe argento' ]
  def enterprises_as_json(passengers)
    passengers.map{ |p| { enterprise_id: p.id, enterprise_denomination: p.name + ' (' + p.cuit + ')' } }.to_json
  end

end
