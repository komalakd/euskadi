json.array!(@payments) do |payment|
  json.extract! payment, :amount, :reservation_id
  json.url payment_url(payment, format: :json)
end
