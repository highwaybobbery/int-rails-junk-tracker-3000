class VehicleBuilder

  VEHICLE_CREATE_PARAM_KEYS = [:type, :nickname, :mileage]
  VEHICLE_UPDATE_PARAM_KEYS = [:nickname, :mileage]

  def initialize(vehicle_params:)
    @vehicle_params = vehicle_params
    @vehicle_klass = vehicle_params[:type]&.constantize
  end

  def create
    vehicle = Vehicle.transaction do
      Vehicle.create(vehicle_params.slice(*VEHICLE_CREATE_PARAM_KEYS)).tap do |vehicle|
        create_engine(vehicle)
        create_doors(vehicle) if has_doors?
        create_seat(vehicle) if has_seat?
        register_vehicle(vehicle)
        create_ad(vehicle)
      end
    end

  end

  def update(existing_vehicle)
    self.vehicle_klass = existing_vehicle.class
    Vehicle.transaction do
      existing_vehicle.update!(vehicle_params.slice(*VEHICLE_UPDATE_PARAM_KEYS))
      update_engine(existing_vehicle)
      update_doors(existing_vehicle) if has_doors?
      update_seat(existing_vehicle) if has_seat?
      update_ad(existing_vehicle)
    end
  end

  private

  attr_accessor :vehicle_klass
  attr_reader :vehicle_params

  def create_engine(vehicle)
    vehicle.create_engine!(vehicle_params[:engine_attributes])
  end

  def update_engine(vehicle)
    if vehicle.engine.present?
      return if vehicle_params[:engine_attributes].blank?
      vehicle.engine.update!(vehicle_params[:engine_attributes])
    else
      create_engine(vehicle)
    end
  end

  def has_doors?
    vehicle_klass::MAX_DOORS > 0
  end

  def create_doors(vehicle)
    return if vehicle_params[:door_attributes].blank?
    vehicle_params[:door_attributes].each do |attrs|
      create_door(vehicle, attrs)
    end
  end

  def update_doors(vehicle)
    return if vehicle_params[:door_attributes].blank?
    vehicle_params[:door_attributes].each do |attrs|
      if attrs[:id]
        update_door(vehicle, attrs)
      else
        create_door(vehicle, attrs)
      end
    end
  end

  def create_door(vehicle, attrs)
    case attrs.delete(:type)
    when 'none'
      # Intentionally blank
    when 'normal'
      vehicle.doors.create!
    when 'sliding'
      vehicle.doors.create!(sliding: true)
    end
  end

  def update_door(vehicle, attrs)
    door = vehicle.doors.detect { |door| door.id == attrs[:id] }
    case attrs.delete(:type)
    when 'none'
      door.destroy
    when 'normal'
      door.update(sliding: false)
    when 'sliding'
      door.update(sliding: true)
    end
  end

  def has_seat?
    vehicle_klass::HAS_SEAT
  end

  def create_seat(vehicle)

  end

  def update_seat(vehicle)

  end

  def register_vehicle(vehicle)
    registration_id = VehicleRegistrationService.register_vehicle(vehicle)
    vehicle.update!(registration_id: registration_id)
  end

  def create_ad(vehicle)
    ad_text = AdBuilder.new(vehicle).create_ad
    ad_id = VehiclePromotionService.create_ad(ad_text)
    vehicle.update!(ad_id: ad_id)
  end

  def update_ad(vehicle)
    ad_text = AdBuilder.new(vehicle).create_ad
    VehiclePromotionService.update_ad(vehicle.ad_id, ad_text)
  end
end
