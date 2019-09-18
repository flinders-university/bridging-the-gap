require 'test_helper'

class DataControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get delete" do
    get data_controller_delete_url
    assert_response :success
  end

end
