json.array!(@pages) do |page|
  json.extract! page, :name
  json.url page_url(page, format: :json)
end
