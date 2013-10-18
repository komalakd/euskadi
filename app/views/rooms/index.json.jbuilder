json.array!(@rooms) do |room|
  json.extract! room, :number, :active
  json.url room_url(room, format: :json)
end
