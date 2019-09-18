require 'test_helper'

class ToolboxControllerTest < ActionDispatch::IntegrationTest
  test "should get markdown" do
    get toolbox_markdown_url
    assert_response :success
  end

end
