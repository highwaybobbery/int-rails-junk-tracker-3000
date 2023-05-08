require "application_system_test_case"

class VehiclesTest < ApplicationSystemTestCase
  setup do
    @vehicle = vehicles(:one)
  end

  test "visiting the index" do
    visit vehicles_url
    assert_selector "h1", text: "Vehicles"
  end

  test "creating a Vehicle" do
    skip('failing because of double post bug')
    visit vehicles_url
    click_on "New Vehicle"

    fill_in "nickname", with: @vehicle.nickname
    click_on "Submit"

    assert_text "Vehicle was successfully created"
    click_on "Back"
  end

  test "updating a Vehicle" do
    skip('failing because of double post bug')

    @vehicle.create_engine
    Vehicle.update_all(ad_id: '1'*30)

    visit vehicles_url
    click_on "Edit", match: :first

    fill_in "nickname", with: @vehicle.nickname
    click_on "Submit"

    assert_text "Vehicle was successfully updated"
  end

  test "destroying a Vehicle" do
    skip('failing because of double post bug')
    visit vehicles_url
    click_on "Destroy", match: :first

    assert_text "Vehicle was successfully destroyed"
  end
end
