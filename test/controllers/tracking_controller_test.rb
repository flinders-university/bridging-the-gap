require 'test_helper'

class TrackingControllerTest < ActionDispatch::IntegrationTest
  test "should get students" do
    get tracking_students_url
    assert_response :success
  end

end
