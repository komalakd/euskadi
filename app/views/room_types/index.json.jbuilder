json.array!(@room_types) do |room_type|
  json.extract! room_type, :denomination, :amount
  json.url room_type_url(room_type, format: :json)
end
