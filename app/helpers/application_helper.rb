module ApplicationHelper

    def rooms_as_json(rooms)
        rooms.collect do |r| 
            {
                room_id: r.id,
                group_id: r.group_id,
                # recursive: r.fecha_hasta,
                # hour_since: r.since.strftime('%H'),
                # hour_until: r.until.strftime('%H'),
                # minutes_since: r.since.strftime('%M'),
                # minutes_until: r.until.strftime('%M'),
                # musician: r.musician.name + ' ' + r.musician.lastname,
                # band: (r.band ? r.band.name : nil),
                # room: r.room_id
            }
        end.to_json
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
