json.array!(@enterprises) do |enterprise|
  json.extract! enterprise, :cuit, :name, :address
  json.url enterprise_url(enterprise, format: :json)
end
