class Sedan < Vehicle
  MAX_DOORS = 4

  validates :doors, length: { in: 0..MAX_DOORS }
end
