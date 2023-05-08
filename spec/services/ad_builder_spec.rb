require "rails_helper"

describe AdBuilder do
  describe "#create_ad" do
    let(:vehicle) { Vehicle.new(nickname: 'some nickname') }
    subject { described_class.new(vehicle) }
    let(:ad_text) { subject.create_ad }

    it "includes Vehicle's nickname" do
      expect(ad_text).to include("some nickname")
    end

    describe "when vehicle is a Sedan" do
      let(:vehicle) do
        Sedan.create(
          nickname: '2020 Honda Civic',
          registration_id: '415Hn3JTu7obqNj151gmuscoq0kWCy',
          mileage: 5_134,
        ).tap do |vehicle|
          vehicle.create_engine(status: 'works')
        end
      end

      it "looks like this" do
        expect(ad_text).to eql(<<~AD)
          2020 Honda Civic
          Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
          Mileage: Low (5,134)
          Engine: Works
        AD
      end
    end

    describe "when vehicle is a Coupe" do
      let(:vehicle) do
        Coupe.create(
          nickname: '2021 Honda Civic',
          registration_id: '415Hn3JTu7obqNj151gmuscoq0kWCy',
          mileage: 21_980,
        ).tap do |vehicle|
          vehicle.create_engine(status: 'works')
        end
      end

      it "looks like this" do
        expect(ad_text).to eql(<<~AD)
          2021 Honda Civic
          Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
          Mileage: Medium (21,980)
          Engine: Works
        AD
      end
    end

    describe "when vehicle is a Mini-Van" do
      let(:vehicle) do
        MiniVan.create(
          nickname: 'Looking for a Mini-Van? Look no further!',
          registration_id: '415Hn3JTu7obqNj151gmuscoq0kWCy',
          mileage: 5_134,
        ).tap do |vehicle|
          vehicle.create_engine(status: 'works')
          vehicle.doors.create()
          vehicle.doors.create()
          vehicle.doors.create(sliding: true)
          vehicle.doors.create(sliding: true)
        end
      end

      it "looks like this" do
        expect(ad_text).to eql(<<~AD)
          Looking for a Mini-Van? Look no further!
          Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
          Mileage: Low (5,134)
          Engine: Works
          Regular Doors: 2
          Sliding Doors: 2
        AD
      end
    end

    describe "when vehicle is a Motorcycle" do
      let(:vehicle) do
        Motorcycle.create(
          nickname: '~~~ Motorcycle for Sale ~~~',
          registration_id: '415Hn3JTu7obqNj151gmuscoq0kWCy',
          mileage: 105_777,
        ).tap do |vehicle|
          vehicle.create_engine(status: 'works')
          vehicle.create_seat(status: 'fixable')
        end
      end

      it "looks like this" do
        expect(ad_text).to eql(<<~AD)
          ~~~ Motorcycle for Sale ~~~
          Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
          Mileage: High (105,777)
          Engine: Works
          Seat: Fixable
        AD
      end

      context 'without a seat' do
        let(:vehicle) do
          super().tap do |vehicle|
            vehicle.seat.destroy
            vehicle.reload
          end
        end

        it 'looks like this' do
          expect(ad_text).to eql(<<~AD)
            ~~~ Motorcycle for Sale ~~~
            Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
            Mileage: High (105,777)
            Engine: Works
            Seat: None
          AD
        end
      end

      context 'without an engine' do
        let(:vehicle) do
          super().tap do |vehicle|
            vehicle.engine.destroy
            vehicle.reload
          end
        end

        it 'looks like this' do
          expect(ad_text).to eql(<<~AD)
            ~~~ Motorcycle for Sale ~~~
            Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
            Mileage: High (105,777)
            Engine: None
            Seat: Fixable
          AD
        end
      end
    end
  end
end
