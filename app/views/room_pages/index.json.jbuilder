json.array!(@room_pages) do |room_page|
  json.extract! room_page, :page_id, :order
  json.url room_page_url(room_page, format: :json)
end
