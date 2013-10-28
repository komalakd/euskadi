json.array!(@reservation_rooms) do |reservation_room|
  json.extract! reservation_room, :reservation_id, :amount, :since, :until
  json.url reservation_room_url(reservation_room, format: :json)
end
