class MiniVan < Vehicle
  MAX_DOORS = 4
  ALLOW_SLIDING_DOORS = true

  validates :doors, length: { in: 0..MAX_DOORS }
end
