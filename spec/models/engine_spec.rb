require 'rails_helper'

RSpec.describe Engine, type: :model do
  describe '#status' do
    let(:vehicle) { Vehicle.create(type: 'Sedan', mileage: 0) }

    it 'defaults to works' do
      expect(Engine.new(vehicle: vehicle).status).to eq 'works'
    end

    it 'is valid with works, fixible, or junk' do
      Engine::ALL_STATUSES.each do |status|
        expect(Engine.new(status: status, vehicle: vehicle)).to be_valid
      end
    end

    it 'is invalid with any other status' do
      expect(Engine.new(status: 'bad', vehicle: vehicle)).to be_invalid
    end
  end
end
