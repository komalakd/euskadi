json.array!(@enterprises) do |enterprise|
  json.extract! enterprise, :cuil, :name
  json.url enterprise_url(enterprise, format: :json)
end
