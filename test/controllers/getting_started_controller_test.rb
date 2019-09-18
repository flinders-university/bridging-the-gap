require 'test_helper'

class GettingStartedControllerTest < ActionDispatch::IntegrationTest
  test "should get information" do
    get getting_started_information_url
    assert_response :success
  end

end
