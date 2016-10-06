require 'test_helper'

class ConferenceManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get conference_management_index_url
    assert_response :success
  end

end
