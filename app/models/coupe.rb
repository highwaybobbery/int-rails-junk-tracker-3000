class Coupe < Vehicle
  MAX_DOORS = 2

  validates :doors, length: { in: 0..MAX_DOORS }
end
