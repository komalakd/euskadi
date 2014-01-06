module ApplicationHelper

    def rooms_as_json(rooms)
        rooms.collect do |r| 
            {
                room_id: r.id,
                group_id: r.group_id,
            }
        end.to_json
    end

    def reservation_as_json(r)
        {
            id: r.id,
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

    def groups_as_json(groups)
        groups.collect do |g| 
            {
                group_id: g.id,
                rooms: g.rooms.collect do |r| 
                    r.id
                end
            }
        end.to_json
    end

end
