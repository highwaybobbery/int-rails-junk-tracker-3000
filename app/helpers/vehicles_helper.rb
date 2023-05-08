module VehiclesHelper
  def vehicle_json(vehicle)
    vehicle.as_json(
      methods: [:type],
      include: [
        doors: { only: [:id], methods: [:type] },
        engine: { only: [:id, :status] },
      ]
    )
  end

  def vehicle_index_json(vehicles)
    vehicles.map do |vehicle|
      vehicle.as_json(
        methods: [:type],
        only: [:id, :nickname, :registration_id]
      )
    end
  end
end
