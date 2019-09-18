require 'test_helper'

class ContactDatabaseControllerTest < ActionDispatch::IntegrationTest
  test "should get interface" do
    get contact_database_interface_url
    assert_response :success
  end

end
