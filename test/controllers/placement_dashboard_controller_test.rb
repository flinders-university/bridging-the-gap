require 'test_helper'

class PlacementDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get preservice_teacher" do
    get placement_dashboard_preservice_teacher_url
    assert_response :success
  end

  test "should get industry" do
    get placement_dashboard_industry_url
    assert_response :success
  end

end
