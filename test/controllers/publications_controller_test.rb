require 'test_helper'

class PublicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get publications_index_url
    assert_response :success
  end

end
