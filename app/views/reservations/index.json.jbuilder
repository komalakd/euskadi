json.array!(@reservations) do |reservation|
  json.extract! reservation, :user_id, :enterprise_id, :amount
  json.url reservation_url(reservation, format: :json)
end
