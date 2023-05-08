class Vehicle < ApplicationRecord
  ALLOW_SLIDING_DOORS = false
  HAS_SEAT = false
  DEFAULT_MILEAGE = 0

  has_many :doors, foreign_key: :vehicle_id, dependent: :delete_all
  has_one :engine, foreign_key: :vehicle_id, dependent: :delete

  after_initialize :set_defaults

  private

  def set_defaults
    self.mileage ||= DEFAULT_MILEAGE
  end
end
