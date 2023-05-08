require 'rails_helper'

describe Sedan do
  describe 'has up to 4 doors' do
    subject do
      build_sedan(door_count: door_count)
    end

    context 'with 0 doors' do
      let(:door_count) { 0 }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'with 4 doors' do
      let(:door_count) { 4 }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'with 5 doors' do
      let(:door_count) { 6 }

      it 'is invalid, does not create the 5th door' do
        expect(subject).to be_invalid
        expect(Door.count).to eq 4
      end
    end

    def build_sedan(door_count: 0)
      Sedan.create(
        nickname: 'my car',
        mileage: 0,
      ).tap do |sedan|
        door_count.times do
          sedan.doors.create
        end
        sedan.create_engine!
      end
    end
  end

  it 'does not allow sliding doors' do

  end
end
