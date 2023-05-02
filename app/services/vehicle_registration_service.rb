# Note: Feel free to leave this class as-is unless modifications are required
# for the rest of your solution, in which case change whatever you'd like.

class VehicleRegistrationService
  def self.register_vehicle(vehicle)
    raise "Vehicle model is required to complete registration!" unless vehicle.is_a?(Vehicle)

    # Pretend we're making a request to an external service :)
    sleep(3)

    charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
    Array.new(30) { charset.sample }.join
  end
end
