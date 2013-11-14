json.array!(@enterprises) do |enterprise|
  json.extract! enterprise, :cuit, :name
  json.url enterprise_url(enterprise, format: :json)
end
