class Motorcycle < Vehicle
  MAX_DOORS = 0
  HAS_SEAT = true

  has_one :seat, foreign_key: :vehicle_id, dependent: :delete

  validates :doors, length: { in: 0..MAX_DOORS }
end
