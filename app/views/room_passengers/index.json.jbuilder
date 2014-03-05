json.array!(@room_passengers) do |room_passenger|
  json.extract! room_passenger, :reservation_room_id, :passenger_id
  json.url room_passenger_url(room_passenger, format: :json)
end
