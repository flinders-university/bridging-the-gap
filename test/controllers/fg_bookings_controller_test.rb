require 'test_helper'

class FgBookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fg_booking = fg_bookings(:one)
  end

  test "should get index" do
    get fg_bookings_url
    assert_response :success
  end

  test "should get new" do
    get new_fg_booking_url
    assert_response :success
  end

  test "should create fg_booking" do
    assert_difference('FgBooking.count') do
      post fg_bookings_url, params: { fg_booking: { booking: @fg_booking.booking, user_id: @fg_booking.user_id } }
    end

    assert_redirected_to fg_booking_url(FgBooking.last)
  end

  test "should show fg_booking" do
    get fg_booking_url(@fg_booking)
    assert_response :success
  end

  test "should get edit" do
    get edit_fg_booking_url(@fg_booking)
    assert_response :success
  end

  test "should update fg_booking" do
    patch fg_booking_url(@fg_booking), params: { fg_booking: { booking: @fg_booking.booking, user_id: @fg_booking.user_id } }
    assert_redirected_to fg_booking_url(@fg_booking)
  end

  test "should destroy fg_booking" do
    assert_difference('FgBooking.count', -1) do
      delete fg_booking_url(@fg_booking)
    end

    assert_redirected_to fg_bookings_url
  end
end
