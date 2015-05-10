# Fetches user ids in JSON array upon Ajax request.
json.array!(@users) do |user|
  json.extract! user, :id
end
