json.extract! vehicle, :type, :id, :nickname, :registration_id
puts "IM WORKIN HERE"
json.doors(vehicle.doors) do |door|
  json.extract! door, :id, :sliding
end
json.url vehicle_url(vehicle, format: :json)
