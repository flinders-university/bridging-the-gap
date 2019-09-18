require 'test_helper'

class AnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get answers_update_url
    assert_response :success
  end

  test "should get check" do
    get answers_check_url
    assert_response :success
  end

end
