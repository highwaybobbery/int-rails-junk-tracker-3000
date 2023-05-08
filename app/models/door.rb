class Door < ApplicationRecord
  belongs_to :vehicle

  validate :vehicle_can_support_door


  def vehicle_can_support_door
    if new_record? && vehicle.doors.length >= vehicle.class::MAX_DOORS
      errors.add :vehicle, "too many doors for #{vehicle.class}"
    end
  end

  def type
    sliding? ? 'sliding' : 'normal'
  end
end
