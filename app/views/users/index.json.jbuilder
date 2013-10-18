json.array!(@users) do |user|
  json.extract! user, :login, :password, :email, :name, :lastname
  json.url user_url(user, format: :json)
end
