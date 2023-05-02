require "rails_helper"

describe "AdBuilder" do
  describe "#create_ad" do
    let(:vehicle) { Vehicle.new }

    it "includes Vehicle's nickname" do
      vehicle.nickname = "some nickname"

      expect(AdBuilder.create_ad(vehicle)).to include("some nickname")
    end

    # The following specs are expected to fail. Please make them pass and 
    # add any more that are relevant.
    #
    # (Feel free to modify any source or test code, as long as the desired 
    # functionality captured by these specs are maintained.)

    describe "when vehicle is a Sedan" do
      it "looks like this" do
        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          2020 Honda Civic
          Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
          Mileage: Low (5,134)
          Engine: Works
        AD
      end
    end

    describe "when vehicle is a Coupe" do
      it "looks like this" do
        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          2021 Honda Civic
          Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
          Mileage: Medium (21,980)
          Engine: Works
        AD
      end
    end

    describe "when vehicle is a Mini-Van" do
      it "looks like this" do
        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          Looking for a Mini-Van? Look no further!

          ~~~ 2009 Dodge Caravan ~~~

          Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
          Mileage: Low (5,134)
          Engine: Works
          Regular Doors: 2
          Sliding Doors: 2
        AD
      end
    end

    describe "when vehicle is a Motorcycle" do
      it "looks like this" do
        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          ~~~ Motorcycle for Sale ~~~

          2019 Ducati Sportbike Motorcycle PANIGALE V4 SPECIALE

          Registration number: 
          415Hn3JTu7obqNj151gmuscoq0kWCy

          Mileage: 
          High (105,777)

          Engine: 
          Works

          Seat: 
          Fixable 
        AD
      end
    end
  end
end