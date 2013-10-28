json.array!(@group_rooms) do |group_room|
  json.extract! group_room, :room_id, :group_id
  json.url group_room_url(group_room, format: :json)
end
