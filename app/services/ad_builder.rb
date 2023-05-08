class AdBuilder
  include ActionView::Helpers::NumberHelper

  attr_reader :ad_text, :vehicle

  def initialize(vehicle)
    @vehicle = vehicle
    @ad_text = ''
  end

  def create_ad
    add_nickname
    add_registration
    add_mileage
    add_engine
    add_doors if vehicle.is_a? MiniVan
    add_seat if vehicle.is_a? Motorcycle

    ad_text
  end

  def add_nickname
    ad_text << "#{vehicle.nickname}\n"
  end

  def add_registration
    ad_text << "Registration number: #{vehicle.registration_id}\n"
  end

  def add_mileage
    modifier = case vehicle.mileage
    when (0...20_000)
       'Low'
    when (20_000...100_000)
      'Medium'
    else
      'High'
    end
    ad_text << "Mileage: #{modifier} (#{number_with_delimiter(vehicle.mileage)})\n"
  end

  def add_engine
    ad_text << "Engine: #{vehicle.engine&.status&.titleize || 'None' }\n"
  end

  def add_doors
    door_memo = {regular:  0, sliding: 0}
    vehicle.doors.each do |door|
      if door.sliding
        door_memo[:sliding] += 1
      else
        door_memo[:regular] += 1
      end
    end

    ad_text << "Regular Doors: #{door_memo[:regular]}\n"
    ad_text << "Sliding Doors: #{door_memo[:sliding]}\n"
  end

  def add_seat
    ad_text << "Seat: #{vehicle.seat&.status&.titleize || 'None'}\n"
  end
end
