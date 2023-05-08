require 'rails_helper'

describe VehicleBuilder do
  describe '#create' do

    let(:params) do
      {
        type: 'Motorcycle',
        mileage: 99,
      }
    end

    subject { described_class.new(vehicle_params: params) }

    let(:result) { subject.create }


    context 'with valid motorcycle params' do
      it 'selects the correct vehicle type' do
        expect(result.class).to eq Motorcycle
      end

      it 'sets mileage' do
        expect(result.mileage).to eq 99
      end
    end

    context 'with no engine_attributes' do
      it 'creates an engine with status of works' do
        expect(result.engine.status).to eq 'works'
      end
    end

    context 'with valid engine status' do
      let(:params) { super().merge(engine_attributes: { status: 'junk' }) }

      it 'creates an engine with the passed status' do
        expect(result.engine.status).to eq 'junk'
      end
    end
  end
end
