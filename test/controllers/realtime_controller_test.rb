require 'test_helper'

class RealtimeControllerTest < ActionDispatch::IntegrationTest
  test "should get answers" do
    get realtime_answers_url
    assert_response :success
  end

end
